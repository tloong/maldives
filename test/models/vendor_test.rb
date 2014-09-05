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

require 'test_helper'

class VendorTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
