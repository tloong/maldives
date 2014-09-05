class AddColumnOfPart2 < ActiveRecord::Migration
  def change
    add_column :fixedasset_parts, :refed_department_id, :integer
  end
end
