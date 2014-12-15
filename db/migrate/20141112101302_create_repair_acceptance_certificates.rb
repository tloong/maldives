class CreateRepairAcceptanceCertificates < ActiveRecord::Migration
  def change
    create_table :repair_acceptance_certificates do |t|
      t.string :repair_accept_cert_no
      t.date :request_date
      t.string :repair_requisition_no
      t.integer :repair_requisition_department
      t.date :accept_cert_date
      t.integer :accept_cert_department
      t.integer :vendor_id
      t.float :amount
      t.float :tax
      t.float :discount_amount
      t.float :discount_tax
      t.string :invoice_no
      t.date :invoice_date

      t.timestamps
    end
  end
end
