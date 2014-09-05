class AddLastUpdateDateOntoFixedassets < ActiveRecord::Migration
  def change
    add_column :fixedassets, :update_value_date, :date
  end
end
