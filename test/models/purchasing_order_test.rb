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

require 'test_helper'

class PurchasingOrderTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
