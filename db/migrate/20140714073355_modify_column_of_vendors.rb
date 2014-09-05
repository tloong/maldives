class ModifyColumnOfVendors < ActiveRecord::Migration
  def change
    change_column :vendors, :notification_method, :integer
  end
end
