class RemoveContactNameFromVendors < ActiveRecord::Migration
  def change
    remove_column :vendors, :contact_last_name
    remove_column :vendors, :contact_first_name
  end
end
