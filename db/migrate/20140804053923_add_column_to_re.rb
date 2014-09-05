class AddColumnToRe < ActiveRecord::Migration
  def change
    add_column :fixedasset_changeds, :evaluated_value, :integer
    add_column :fixedasset_changeds, :evaluated_scrap_value, :inetger
  end
end
