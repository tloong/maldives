class ClearNotUseColumn < ActiveRecord::Migration
  def change
    remove_column :fixedassets, :accumulated_depreciated_value
    remove_column :fixedassets, :update_value_date
    remove_column :fixedassets, :depreciated_value_this_year
    remove_column :fixedasset_redepreciations, :re_accumulated_depreciated_value
    remove_column :fixedasset_redepreciations, :re_depreciated_value_this_year
    drop_table :fixedasset_legacy_infos
    drop_table :fixedasset_transferreds
  end
end
