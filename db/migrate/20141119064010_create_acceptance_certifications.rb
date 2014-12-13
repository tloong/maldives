class CreateAcceptanceCertifications < ActiveRecord::Migration
  def change
    create_table :acceptance_certifications do |t|
      t.string :accept_cert_no
      t.date :accept_cert_date
      t.integer :currency
      t.float :exchange_rate
      t.float :amount
      t.float :tax
      t.float :discount_amount
      t.float :discount_tax
      t.string :invoice_no
      t.date :invoice_date
      t.text :note_for_payment
      t.string :voucher_no
      t.date :voucher_date
      t.integer :acc_type
      t.integer :vendor_id
      t.integer :user_id

      t.timestamps
    end
  end
end
