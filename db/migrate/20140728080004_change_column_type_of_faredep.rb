class ChangeColumnTypeOfFaredep < ActiveRecord::Migration
  def change
    change_column :fixedasset_redepreciations, :original_value, :integer
    change_column :fixedasset_redepreciations, :final_scrap_value, :integer
  end
end
