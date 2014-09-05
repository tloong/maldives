class ChangeColumnNameOfFixedasset < ActiveRecord::Migration
  def change
    rename_column :fixedassets, :owned_department, :department_id
  end
end
