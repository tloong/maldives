# == Schema Information
#
# Table name: vendor_addresses
#
#  id                  :integer          not null, primary key
#  created_at          :datetime
#  updated_at          :datetime
#  building_and_street :string(255)
#  zipcode             :string(255)
#  country             :string(255)
#  address_type        :integer
#  vendor_id           :integer
#

require 'test_helper'

class VendorAddressTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
