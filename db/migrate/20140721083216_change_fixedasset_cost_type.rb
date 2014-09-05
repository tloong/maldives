class ChangeFixedassetCostType < ActiveRecord::Migration
  def change
    change_column :fixedassets, :original_cost, :integer
    change_column :fixedassets, :scrap_value, :integer
  end
end
