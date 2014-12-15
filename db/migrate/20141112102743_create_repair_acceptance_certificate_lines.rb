class CreateRepairAcceptanceCertificateLines < ActiveRecord::Migration
  def change
    create_table :repair_acceptance_certificate_lines do |t|
      t.integer :repair_acceptance_certification_id
      t.integer :sequence_no
      t.integer :material_id
      t.float :received_quantity
      t.float :unit_price
      t.float :total_amount
      t.float :tax
      t.float :discount_amount
      t.float :discount_tax
      t.text :repair_reason
      t.integer :machine_category
      t.integer :machine_id
      t.integer :repair_requisition_department
      t.integer :cost_department
      t.date :repair_accept_cert_date
      t.integer :acc_type
      t.integer :speical_code

      t.timestamps
    end
  end
end
