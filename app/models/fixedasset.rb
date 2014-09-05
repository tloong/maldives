# == Schema Information
#
# Table name: fixedassets
#
#  id                            :integer          not null, primary key
#  fixed_asset_id                :string(255)      not null
#  ab_type                       :string(255)      not null
#  year                          :integer          not null
#  category_id                  :integer          not null
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

  def scrap_value
    if ( self.status == "is_sold" || self.status == "is_scrapped")
      scrap_value = self.original_cost - self.accumulated_depreciated_value
    elsif (self.status == "depreciated_done")
      scrap_value = self.original_cost - self.accumulated_depreciated_value
    elsif (self.status == "in_use")
      original_cost = self.original_cost
      accumulated_depreciated_value = self.accumulated_depreciated_value
      depreciated_value_per_month = self.depreciated_value_per_month
      depreciated_value_last_month = self.depreciated_value_last_month
      end_date = self.end_use_date
      update_value_date = self.update_value_date
    elsif (self.status == "in_use_extended")
      original_cost = self.original_cost
      accumulated_depreciated_value = self.accumulated_depreciated_value
      depreciated_value_per_month = self.depreciated_value_per_month
      depreciated_value_last_month = self.depreciated_value_last_month
      end_date = self.end_use_date
      update_value_date = self.update_value_date
    end

    if (self.status == "in_use_extended" or self.status =="in_use")
      month_diff = month_difference(DateTime.now, self.update_value_date)
      
      if (month_diff <= 0)
        scrap_value = original_cost - accumulated_depreciated_value
      elsif (month_diff > 0)
        scrap_value = original_cost - accumulated_depreciated_value
        accumulated_depreciated_value = accumulated_depreciated_value + depreciated_value_per_month * month_diff
        if (month_difference(DateTime.now, end_date)==0)
          scrap_value = scrap_value + depreciated_value_per_month - depreciated_value_last_month
        end
      end
    end
    return scrap_value
  end

  self.per_page = 30
end
