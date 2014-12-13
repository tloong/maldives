class CreateAcceptanceLineitems < ActiveRecord::Migration
  def change
    create_table :acceptance_lineitems do |t|
      t.integer :acceptance_certification_id
      t.integer :purchasing_order_lineitem_id
      t.float :received_quantity
      t.float :accepted_quantity
      t.float :ng_quantity
      t.float :unit_price
      t.float :total_amount
      t.float :tax
      t.float :discount_amount
      t.float :discount_tax
      t.integer :received_department_id
      t.integer :acc_type
      t.integer :cost_department_id
      t.integer :special_flag

      t.timestamps
    end
  end
end
