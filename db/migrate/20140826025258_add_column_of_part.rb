class AddColumnOfPart < ActiveRecord::Migration
  def change
    rename_column :fixedasset_parts, :refed_department_id, :part_no
  end
end
