class CreatePurchasingOrderLineitems < ActiveRecord::Migration
  def change
    create_table :purchasing_order_lineitems do |t|
      t.integer :purchasing_order_id
      t.integer :sequence_no
      t.integer :material_id
      t.integer :quantity
      t.float :purchased_unit_price
      t.float :amount
      t.float :tax
      t.string :purchasing_requisition_no
      t.integer :purchasing_requsition_seq_no
      t.string :purchasing_purpose
      t.date :purchasing_requisition_date
      t.date :goods_need_date
      t.integer :shipping_location
      t.integer :acceptance_certification_no
      t.boolean :close_case
      t.integer :acc_type
      t.integer :cost_department

      t.timestamps
    end
  end
end
