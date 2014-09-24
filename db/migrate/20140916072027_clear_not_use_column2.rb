class ClearNotUseColumn2 < ActiveRecord::Migration
  def change
    remove_column :fixedasset_redepreciations, :re_update_value_date
  end
end
