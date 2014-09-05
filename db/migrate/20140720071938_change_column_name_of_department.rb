class ChangeColumnNameOfDepartment < ActiveRecord::Migration
  def change
    rename_column :departments, :department_id, :dep_id
  end
end
