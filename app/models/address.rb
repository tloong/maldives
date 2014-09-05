# == Schema Information
#
# Table name: addresses
#
#  id                     :integer          not null, primary key
#  line1_address_building :text
#  line2_address_street   :string(255)
#  city                   :string(255)
#  zipcode                :integer
#  state_province_county  :string(255)
#  country                :string(255)
#  created_at             :datetime
#  updated_at             :datetime
#

class Address < ActiveRecord::Base
end
