class ModifyContactsFieldOfVendors < ActiveRecord::Migration
  def change
    remove_column :vendors, :contact_phone
    remove_column :vendors, :contact_phone2
    remove_column :vendors, :contact_phone3
    remove_column :vendors, :email
  end
end
