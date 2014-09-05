class CreateVendorAddresses < ActiveRecord::Migration
  def change
    create_table :vendor_addresses do |t|
      t.belongs_to :vendor
      t.references :address
      t.integer :address_type
      t.timestamps
    end
  end
end
