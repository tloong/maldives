class DeleteIsMortgagedToFixedassets < ActiveRecord::Migration
  def change
    remove_column :fixedassets, :is_mortgaged
  end
end
