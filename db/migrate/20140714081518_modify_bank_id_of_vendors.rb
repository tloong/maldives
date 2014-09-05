class ModifyBankIdOfVendors < ActiveRecord::Migration
  def change
    change_column :vendors, :bank_id, :string
  end
end
