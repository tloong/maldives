class CreateMaterialCats < ActiveRecord::Migration
  def change
    create_table :material_cats do |t|
      t.string :lv2
      t.string :cat_id
      t.string :cat_name

      t.timestamps
    end
  end
end
