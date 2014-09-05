class AddOutDateToFixedassets < ActiveRecord::Migration
  def change
    add_column :fixedassets, :out_date, :date
  end
end
