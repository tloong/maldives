class CreateAddresses < ActiveRecord::Migration
  def change
    create_table :addresses do |t|
      t.text    :line1_address_building
      t.string  :line2_address_street
      t.string  :city
      t.integer :zipcode
      t.string  :state_province_county
      t.string  :country
      t.timestamps
    end
  end
end
