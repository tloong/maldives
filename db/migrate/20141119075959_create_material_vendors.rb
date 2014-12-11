class CreateMaterialVendors < ActiveRecord::Migration
  def change
    create_table :material_vendors do |t|
      t.string :sno
      t.string :name
      t.string :sid

      t.timestamps
    end
  end
end
