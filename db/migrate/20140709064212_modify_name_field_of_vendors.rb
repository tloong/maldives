class ModifyNameFieldOfVendors < ActiveRecord::Migration
  def change
    add_column :vendors, :pic_name, :string
    remove_column :vendors, :pic_last_name
    remove_column :vendors, :pic_first_name
  end
end
