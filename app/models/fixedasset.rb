# == Schema Information
#
# Table name: fixedassets
#
#  id                            :integer          not null, primary key
#  fixed_asset_id                :string(255)      not null
#  ab_type                       :string(255)      not null
#  year                          :integer          not null
#  category_id                   :integer          not null
#  category_lv2                  :string(255)      not null
#  serial_no                     :integer          not null
#  sequence_no                   :integer          not null
#  voucher_no                    :integer
#  name                          :string(255)      not null
#  spec                          :text
#  quantity                      :integer          default(0), not null
#  unit                          :string(255)
#  original_cost                 :integer
#  get_date                      :date
#  service_life_year             :integer
#  service_life_month            :integer
#  depreciated_value_per_month   :integer
#  depreciated_value_last_month  :integer
#  accumulated_depreciated_value :integer
#  department_id                 :integer
#  vendor_id                     :integer
#  status                        :integer
#  note                          :text
#  start_use_date                :date
#  created_at                    :datetime
#  updated_at                    :datetime
#  username                      :string(255)
#  depreciation84                :integer
#  update_value_date             :date
#  final_scrap_value             :integer
#  depreciated_value_this_year   :integer
#  is_mortgaged                  :boolean
#  end_use_date                  :date
#  out_date                      :date
#

class Fixedasset < ActiveRecord::Base
  
  has_paper_trail :only => [:quantity, :original_cost, :department_id, :status, :start_use_date, :get_date]
  validates :fixed_asset_id, presence: true, uniqueness: true, 
                             format: { with: /\A[ab]\d{3}[a-z]\d{3}-\d{2}\z/i}
  validates :name, presence: true
  validates :quantity, presence: true
  validates :original_cost, presence: true
  validates :service_life_year, presence: true
  validates :service_life_month, presence: true
  validates :department, presence: true
  belongs_to :vendor
  belongs_to :department
  has_many :fixedasset_changeds
  has_one :fixedasset_redepreciation
  has_one :fixedasset_category

  enum status: { "in_use" => 0, "in_use_extended" => 1, "depreciated_done"=>2, "in_use_mortgaged" =>3, "in_use_extended_mortgaged" =>4,
                 "depreciated_done_mortgaged" => 5, "is_scrapped" => 6, "is_sold" => 7}

  ERROR_CODE = [NO_ERROR = 0, PARAMS_BLANK = 1]


  attr_accessor :current_scrap_value,:accumulated_depreciated_value, :accumulated_depreciated_value_this_year

  
  def scrap_value
    if @accumulated_depreciated_value == nil
      calculate()
    end
    return self.original_cost - @accumulated_depreciated_value
  end

  def month_difference(end_date, start_date)
    year_diff = end_date.year - start_date.year
    month_diff = end_date.month - start_date.month

    if (month_diff < 0)
      year_diff = year_diff - 1
      month_diff = month_diff + 12
    end
    total_month = year_diff * 12 + month_diff
  end


  def total_depreciated_month
    self.service_life_year*12 + self.service_life_month
  end

  def calculate
    @current_scrap_value = 0
    @accumulated_depreciated_value_this_year = 0
    @accumulated_depreciated_value = 0
    tmp7 = self.final_scrap_value
    tmp10 = 0
    tmp13 = self.original_cost - self.final_scrap_value
    query_date = Date.today
    d84_date = Date.new(1997,1,1)
    this_year = Date.new(Time.now.year,1,1)
    redep = self.fixedasset_redepreciation
    e_date = get_end_date(self.end_use_date,redep)

    if self.start_use_date < e_date
      if (month_difference(e_date,query_date)==0)      
        @accumulated_depreciated_value_this_year = @accumulated_depreciated_value_this_year + self.depreciated_value_per_month * (month_difference(query_date,this_year)) + self.depreciated_value_last_month 
        if (self.depreciation84 > 0)
          @accumulated_depreciated_value = @accumulated_depreciated_value + self.depreciation84 + self.depreciated_value_per_month * (month_difference(query_date,d84_date)) + self.depreciated_value_last_month 
        else
          @accumulated_depreciated_value = @accumulated_depreciated_value + self.depreciated_value_per_month * (month_difference(query_date,self.start_use_date)) + self.depreciated_value_last_month 
        end
      elsif (month_difference(e_date,query_date)<0)
        if (month_difference(e_date,this_year)>=0)
            @accumulated_depreciated_value_this_year = @accumulated_depreciated_value_this_year + self.depreciated_value_per_month * (month_difference(e_date,this_year)) + self.depreciated_value_last_month 
        end
        if (self.depreciation84 > 0)
          @accumulated_depreciated_value = @accumulated_depreciated_value + self.depreciation84 + self.depreciated_value_per_month * (month_difference(e_date,d84_date)) + self.depreciated_value_last_month 
        else
          @accumulated_depreciated_value = @accumulated_depreciated_value + self.depreciated_value_per_month * (month_difference(e_date,self.start_use_date)) + self.depreciated_value_last_month 
        end      
      elsif (month_difference(query_date,self.start_use_date)>=0)
        if (this_year > self.start_use_date)
            @accumulated_depreciated_value_this_year = @accumulated_depreciated_value_this_year + self.depreciated_value_per_month * (month_difference(query_date,this_year) +1)
          else
            @accumulated_depreciated_value_this_year = @accumulated_depreciated_value_this_year + self.depreciated_value_per_month * (month_difference(query_date,self.start_use_date) +1)
        end
        if (self.depreciation84 > 0)
          @accumulated_depreciated_value = @accumulated_depreciated_value + self.depreciation84 + self.depreciated_value_per_month * (month_difference(query_date,d84_date) +1)
        else
          @accumulated_depreciated_value = @accumulated_depreciated_value + self.depreciated_value_per_month * (month_difference(query_date,self.start_use_date) +1)
        end
      end
    end
    if redep != nil
      tmp13 = tmp13 + redep.re_original_value - redep.re_final_scrap_value
      if (month_difference(redep.re_end_use_date,query_date)==0)
        @accumulated_depreciated_value_this_year = @accumulated_depreciated_value_this_year + redep.re_depreciated_value_per_month * (month_difference(query_date,this_year)) + redep.re_depreciated_value_last_month 
        @accumulated_depreciated_value = @accumulated_depreciated_value + redep.re_depreciated_value_per_month * (month_difference(query_date,redep.re_start_use_date)) + redep.re_depreciated_value_last_month 
      elsif (month_difference(redep.re_end_use_date,query_date)<0)
        if (month_difference(redep.re_end_use_date,this_year)>=0)
          @accumulated_depreciated_value_this_year = @accumulated_depreciated_value_this_year + redep.re_depreciated_value_per_month * (month_difference(redep.re_end_use_date,this_year)) + redep.re_depreciated_value_last_month 
        end
        @accumulated_depreciated_value = @accumulated_depreciated_value + redep.re_depreciated_value_per_month * (month_difference(redep.re_end_use_date,redep.re_start_use_date)) + redep.re_depreciated_value_last_month 
      elsif (month_difference(query_date,redep.re_start_use_date)>=0)
        @accumulated_depreciated_value = @accumulated_depreciated_value + redep.re_depreciated_value_per_month * (month_difference(query_date,redep.re_start_use_date) +1)
        if (this_year > redep.re_start_use_date)
          @accumulated_depreciated_value_this_year = @accumulated_depreciated_value_this_year + redep.re_depreciated_value_per_month * (month_difference(query_date,this_year) +1)
        else
          @accumulated_depreciated_value_this_year = @accumulated_depreciated_value_this_year + redep.re_depreciated_value_per_month * (month_difference(query_date,redep.re_start_use_date) +1)
        end
      end
    end

    f_reev = self.fixedasset_changeds

    f_reev.each do |ffe|        
      if (ffe.change_type == 3)
        @current_scrap_value = ffe.evaluated_scrap_value - self.final_scrap_value
        tmp13 = tmp13 + (ffe.evaluated_value - self.original_cost) - (ffe.evaluated_scrap_value - self.final_scrap_value) 
      end
    end
    
    @current_scrap_value = @current_scrap_value + tmp13 - @accumulated_depreciated_value + tmp7 - tmp10
   
  end

  def current_scrap_value 
    if @current_scrap_value == nil
      calculate()
    end
    return @current_scrap_value
  end

  def accumulated_depreciated_value 
    if @accumulated_depreciated_value == nil
      calculate()
    end
    return @accumulated_depreciated_value
  end

  def accumulated_depreciated_value_this_year
    if @accumulated_depreciated_value_this_year == nil
      calculate()
    end
    return @accumulated_depreciated_value_this_year
  end

  self.per_page = 30

private
  def accumulated_depreciated_value=(value)
    @accumulated_depreciated_value = value
  end
  def accumulated_depreciated_value_this_year=(value)
    @accumulated_depreciated_value_this_year = value
  end
  def current_scrap_value=(value)
    @current_scrap_value = value
  end
  def get_end_date (end_date, redep)
    e_date = end_date
    if redep != nil
      if (end_date > redep.re_start_use_date)
        e_date = redep.re_start_use_date - 1.month
      end
    end
    return e_date
  end
end
