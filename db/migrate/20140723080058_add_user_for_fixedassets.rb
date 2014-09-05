class AddUserForFixedassets < ActiveRecord::Migration
  def change
    add_column :fixedassets, :username, :string
  end
end
