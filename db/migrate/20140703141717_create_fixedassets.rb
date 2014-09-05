class CreateFixedassets < ActiveRecord::Migration
  def change
    create_table :fixedassets do |t|
      # 固定資產編碼
      t.string :fixed_asset_id, null: false, index: true
      t.string :ab_type,        null: false, index: true
      t.integer :year,          null: false, index: true
      t.integer :category_lv1,  null: false, index: true
      t.string :category_lv2,   null: false, index: true
      t.integer :serial_no,     null: false
      t.integer :sequence_no,   null: false

      # 固定資產基本資料
      t.integer :voucher_no,    null: false, index: true
      t.string :name,           null: false
      t.text :spec
      t.integer :quantity,      null: false, default: 0
      t.string :unit
      t.float :original_cost
      t.float :scrap_value
      t.date :get_date
      t.integer :service_life_year
      t.integer :service_life_month
      t.integer :depreciated_value_per_month
      t.integer :depreciated_value_last_month
      t.integer :accumulated_depreciated_value
      t.integer :owned_department, index: true
      t.references :vendor
      t.integer :status, index: true
      t.text :note
      t.date :start_use_date
      t.boolean :is_mortgaged, index: true

      t.timestamps
    end
  end
end
