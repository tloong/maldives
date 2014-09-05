# == Schema Information
#
# Table name: vendor_contacts
#
#  id         :integer          not null, primary key
#  vendor_id  :integer          not null
#  name       :string(255)      not null
#  phone      :string(255)
#  phone2     :string(255)
#  phone3     :string(255)
#  email      :string(255)
#  created_at :datetime
#  updated_at :datetime
#

require 'test_helper'

class VendorContactTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
