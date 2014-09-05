class ChangeFixedassetColumn < ActiveRecord::Migration
  def change
    change_column :fixedassets, :voucher_no, :integer, :null => true
  end
end
