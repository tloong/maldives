class RemoveUnnecessaryColumnOfAddress < ActiveRecord::Migration
  def change
    remove_column :vendor_addresses, :city
    remove_column :vendor_addresses, :state_province_county
  end
end
