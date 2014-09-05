class AddColumnOnFixedassetChangeds < ActiveRecord::Migration
  def change
    add_column :fixedasset_changeds, :old_department_id, :integer
  end
end
