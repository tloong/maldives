class CreateVendors < ActiveRecord::Migration
  def change
    create_table :vendors do |t|
      t.integer :old_vendor_id, null: false, index: true
      t.string :name, null: false
      t.string :alias
      t.string :pic_first_name
      t.string :pic_last_name
      t.string :contact_first_name
      t.string :contact_last_name
      t.string :contact_phone
      t.string :contact_phone2
      t.string :contact_phone3
      t.string :fax
      t.string :vat_id
      t.string :product_type
      t.string :main_business

      t.integer :payment_location
      t.integer :payment_type
      t.integer :check_usance
      t.integer :bank_id
      t.string :bank_account_id
      t.string :bank_account_name
      t.string :receipter_vat_id
      t.integer :notification_method
      t.string :email
      t.text :notification_method
      t.boolean :is_pay_for_wire_fee
      t.timestamps
    end
  end
end
