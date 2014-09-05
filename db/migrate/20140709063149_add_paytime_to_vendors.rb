class AddPaytimeToVendors < ActiveRecord::Migration
  def change
    add_column :vendors, :payment_time, :integer
  end
end
