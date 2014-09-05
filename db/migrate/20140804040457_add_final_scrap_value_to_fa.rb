class AddFinalScrapValueToFa < ActiveRecord::Migration
  def change
    add_column :fixedassets, :final_scrap_value, :integer
  end
end
