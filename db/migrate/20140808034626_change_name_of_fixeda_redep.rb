class ChangeNameOfFixedaRedep < ActiveRecord::Migration
  def change
    rename_column :fixedasset_redepreciations, :original_value, :re_original_value 
    rename_column :fixedasset_redepreciations, :final_scrap_value, :re_final_scrap_value 
    rename_column :fixedasset_redepreciations, :depreciated_value_per_month, :re_depreciated_value_per_month 
    rename_column :fixedasset_redepreciations, :depreciated_value_last_month, :re_depreciated_value_last_month 
    rename_column :fixedasset_redepreciations, :accumulated_depreciated_value, :re_accumulated_depreciated_value 
    rename_column :fixedasset_redepreciations, :start_use_date, :re_start_use_date 
    rename_column :fixedasset_redepreciations, :update_value_date, :re_update_value_date 
  end
end
