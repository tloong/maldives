class CreateMaterials < ActiveRecord::Migration
  def change
    create_table :materials do |t|
      t.string :mat_id
      t.string :vendor_lot_no
      t.integer :material_cat_lv1_id
      t.integer :material_cat_lv2_id
      t.string :name
      t.string :condition_id
      t.text :description
      t.text :note
      t.integer :accounting_type
      t.integer :debit_code
      t.integer :credit_code
      t.boolean :is_shared_id
      t.boolean :is_quantity_control
      t.boolean :is_sample
      t.string :measure_unit
      t.string :vendor_id

      t.timestamps
    end
  end
end
