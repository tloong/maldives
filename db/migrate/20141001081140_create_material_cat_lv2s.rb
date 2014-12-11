class CreateMaterialCatLv2s < ActiveRecord::Migration
  def change
    create_table :material_cat_lv2s do |t|
      t.string :cat_id
      t.string :cat_name

      t.timestamps
    end
  end
end
