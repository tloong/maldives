class AddDepreciation84ForFixedassets < ActiveRecord::Migration
  def change
    add_column :fixedassets, :depreciation84, :integer
  end
end
