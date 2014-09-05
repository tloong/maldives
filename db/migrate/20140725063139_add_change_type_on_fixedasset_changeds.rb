class AddChangeTypeOnFixedassetChangeds < ActiveRecord::Migration
  def change
    add_column :fixedasset_changeds, :change_type, :integer
  end
end
