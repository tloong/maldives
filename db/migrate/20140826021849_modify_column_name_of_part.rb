class ModifyColumnNameOfPart < ActiveRecord::Migration
  def change
    rename_column :fixedasset_parts, :part_no, :refed_department_id
  end
end
