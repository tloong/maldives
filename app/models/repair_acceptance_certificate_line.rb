# == Schema Information
#
# Table name: repair_acceptance_certificate_lines
#
#  id                               :integer          not null, primary key
#  repair_acceptance_certificate_id :integer
#  sequence_no                      :integer
#  material_id                      :integer
#  received_quantity                :float
#  unit_price                       :float
#  total_amount                     :float
#  tax                              :float
#  discount_amount                  :float
#  discount_tax                     :float
#  repair_reason                    :text
#  machine_category                 :integer
#  machine_id                       :integer
#  repair_requisition_department    :integer
#  cost_department                  :integer
#  repair_accept_cert_date          :date
#  acc_type                         :integer
#  speical_code                     :integer
#  created_at                       :datetime
#  updated_at                       :datetime
#

class RepairAcceptanceCertificateLine < ActiveRecord::Base
  belongs_to :repair_acceptance_certificate
  belongs_to :repair_requisition_department,
               :class_name => "Department",
               :foreign_key => "repair_requisition_department"
  belongs_to :cost_department,
               :class_name => "Department",
               :foreign_key => "cost_department"

  enum acc_type: { "sale" => 0, "manager" => 1, "d_labor" => 2, "nd_labor" => 3}
  enum speical_code: { "S" => 0, "V" => 1, "R" =>2}

end
