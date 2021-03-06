class DropAddressesAndModifyVendorAddresses < ActiveRecord::Migration
  def change
    add_column :vendor_addresses, :building_and_street, :string
    add_column :vendor_addresses, :city, :string
    add_column :vendor_addresses, :zipcode, :string
    add_column :vendor_addresses, :state_province_county, :string
    add_column :vendor_addresses, :country, :string
  end
end
