# == Schema Information
#
# Table name: vendors
#
#  id                  :integer          not null, primary key
#  name                :string(255)      not null
#  alias               :string(255)
#  fax                 :string(255)
#  vat_id              :string(255)
#  product_type        :string(255)
#  main_business       :string(255)
#  payment_location    :integer
#  payment_type        :integer
#  check_usance        :integer
#  bank_id             :string(255)
#  bank_account_id     :string(255)
#  bank_account_name   :string(255)
#  receipter_vat_id    :string(255)
#  notification_method :integer
#  is_pay_for_wire_fee :boolean
#  created_at          :datetime
#  updated_at          :datetime
#  payment_time        :integer
#  pic_name            :string(255)
#

class Vendor < ActiveRecord::Base
  has_many :vendor_addresses, :dependent => :destroy
  has_many :vendor_contacts, :dependent => :destroy

  validates :name, presence: true
  validates :alias, presence: true
     
  accepts_nested_attributes_for :vendor_contacts, 
          :reject_if => :all_blank, allow_destroy: true
  accepts_nested_attributes_for :vendor_addresses, 
          :reject_if => proc {|attributes| attributes['building_and_street'].blank?}, 
          allow_destroy: true
  



  self.per_page = 20

  enum payment_location: { "banqiao" => 0, "taoyuan" => 1, "zhanghua" =>2}
  enum payment_type: {"draw_money"=>0, "send_ty_post"=>1}
  enum payment_time: {"regular"=>0, "in_normal_time"=>1}
  enum notification_method: {"not_notify" =>0, "fax"=>1, "phone"=>2, "email"=>3}

  def to_label
    "#{id.to_s.rjust(4,'0')} #{self.alias}"
  end

end
