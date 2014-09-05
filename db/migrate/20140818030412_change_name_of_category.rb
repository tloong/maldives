class ChangeNameOfCategory < ActiveRecord::Migration
  def change
    rename_column :fixedassets, :category_lv1, :category_id
  end
end
