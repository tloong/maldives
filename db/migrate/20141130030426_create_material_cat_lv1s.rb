class CreateMaterialCatLv1s < ActiveRecord::Migration
  def change
    create_table :material_cat_lv1s do |t|
      t.string :cat_id
      t.string :cat_name

      t.timestamps
    end
  end
end
