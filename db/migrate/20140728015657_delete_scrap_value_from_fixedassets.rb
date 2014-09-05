class DeleteScrapValueFromFixedassets < ActiveRecord::Migration
  def change
    remove_column :fixedassets, :scrap_value
  end
end
