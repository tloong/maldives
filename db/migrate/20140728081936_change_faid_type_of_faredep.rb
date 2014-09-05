class ChangeFaidTypeOfFaredep < ActiveRecord::Migration
  def change
     change_column :fixedasset_redepreciations, :fixedasset_id, :string
  end
end
