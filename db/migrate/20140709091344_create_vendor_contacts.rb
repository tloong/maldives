class CreateVendorContacts < ActiveRecord::Migration
  def change
    create_table :vendor_contacts do |t|
      t.integer :vendor_id, null: false, index: true
      t.string :name, null: false
      t.string :phone
      t.string :phone2
      t.string :phone3
      t.string :email
      t.timestamps
    end
  end
end
