class AddEndDateToFixedassets < ActiveRecord::Migration
  def change
    add_column :fixedassets, :end_use_date, :date
    add_column :fixedasset_redepreciations, :re_end_use_date, :date
  end
end
