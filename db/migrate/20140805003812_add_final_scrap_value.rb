class AddFinalScrapValue < ActiveRecord::Migration
  def change
    add_column :fixedassets, :depreciated_value_this_year, :integer
    add_column :fixedasset_redepreciations, :depreciated_value_this_year, :integer
  end
end
