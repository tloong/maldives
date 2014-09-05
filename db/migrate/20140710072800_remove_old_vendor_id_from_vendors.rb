class RemoveOldVendorIdFromVendors < ActiveRecord::Migration
  def change
    remove_column :vendors, :old_vendor_id
  end
end
