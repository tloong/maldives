class AddMaterialIdToAcceptanceLineitem < ActiveRecord::Migration
  def change
  	add_column :acceptance_lineitems, :material_id, :integer
  end
end
