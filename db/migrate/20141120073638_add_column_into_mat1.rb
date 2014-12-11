class AddColumnIntoMat1 < ActiveRecord::Migration
  def change
  	add_column :materials, :sno, :string
  end
end
