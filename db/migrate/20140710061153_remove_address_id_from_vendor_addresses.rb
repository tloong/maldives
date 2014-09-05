class RemoveAddressIdFromVendorAddresses < ActiveRecord::Migration
  def change
      remove_column :vendor_addresses, :address_id
  end
end
