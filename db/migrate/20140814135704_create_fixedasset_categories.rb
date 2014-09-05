class CreateFixedassetCategories < ActiveRecord::Migration
  def change
    create_table :fixedasset_categories do |t|
      t.string :cat_id, index: true, null: false
      t.string :cat_name, index: true, null: false
      t.timestamps
    end
  end
end
