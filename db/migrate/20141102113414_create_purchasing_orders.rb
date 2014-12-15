class CreatePurchasingOrders < ActiveRecord::Migration
  def change
    create_table :purchasing_orders do |t|
      t.string :purchasing_order_on
      t.date :purchase_date
      t.integer :vendor_id
      t.integer :department_id
      t.integer :currency
      t.float :exchange_rate
      t.float :amount
      t.integer :payment_location
      t.integer :payment_type
      t.integer :check_usance
      t.integer :purchase_method
      t.integer :purchase_category
      t.integer :purchase_employee
      t.boolean :is_prepaid

      t.timestamps
    end
  end
end
