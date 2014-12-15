# == Schema Information
#
# Table name: purchasing_orders
#
#  id                  :integer          not null, primary key
#  purchasing_order_on :string(255)
#  purchase_date       :date
#  vendor_id           :integer
#  department_id       :integer
#  currency            :integer
#  exchange_rate       :float
#  amount              :float
#  payment_location    :integer
#  payment_type        :integer
#  check_usance        :integer
#  purchase_method     :integer
#  purchase_category   :integer
#  purchase_employee   :integer
#  is_prepaid          :boolean
#  created_at          :datetime
#  updated_at          :datetime
#

class PurchasingOrder < ActiveRecord::Base
    has_many :purchasing_order_lineitems
    belongs_to :department
    belongs_to :vendor

    enum payment_location: { "banqiao" => 0, "taoyuan" => 1, "zhanghua" =>2}
    enum payment_type: {"draw_money"=>0, "send_ty_post"=>1}
   #enum purchase_method: {"phone"=>0, "fax"=>1, "order" =>2}
    enum purchase_category:{"internal"=>0, "foreign"=>1}
end
