class AddColumnIntoMat < ActiveRecord::Migration
  def change
  	add_column :materials, :safe_quantity, :integer
  	add_column :materials, :stocktake_quantity, :integer
  	add_column :materials, :last_quantity, :integer
  	add_column :materials, :total_quantity, :integer
  	add_column :materials, :sno, :string
  end
end
