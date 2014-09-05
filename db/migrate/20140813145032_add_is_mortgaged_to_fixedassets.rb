class AddIsMortgagedToFixedassets < ActiveRecord::Migration
  def change
    add_column :fixedassets, :is_mortgaged, :boolean
    add_index :fixedassets, :is_mortgaged
  end
end
