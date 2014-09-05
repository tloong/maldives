class ChangeName2OfFixedaRedep < ActiveRecord::Migration
  def change
    rename_column :fixedasset_redepreciations, :depreciated_value_this_year, :re_depreciated_value_this_year 
  end
end
