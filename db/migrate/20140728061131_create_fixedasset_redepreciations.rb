class CreateFixedassetRedepreciations < ActiveRecord::Migration
  def change
    create_table :fixedasset_redepreciations do |t|
      t.integer :fixedasset_id, null: false, index: true
      t.float :original_value
      t.float :final_scrap_value
      t.integer :depreciated_value_per_month
      t.integer :depreciated_value_last_month
      t.integer :accumulated_depreciated_value
      t.date :start_use_date
      t.date :update_value_date
      t.timestamps
    end
  end
end
