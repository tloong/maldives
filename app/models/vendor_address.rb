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

class VendorAddress < ActiveRecord::Base
  belongs_to :vendor
  validate :building_and_street

  enum address_type: { "company" => 0, "factory" => 1}
  

end
