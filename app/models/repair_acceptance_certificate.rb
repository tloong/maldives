# == Schema Information
#
# Table name: repair_acceptance_certificates
#
#  id                            :integer          not null, primary key
#  repair_accept_cert_no         :string(255)
#  request_date                  :date
#  repair_requisition_no         :string(255)
#  repair_requisition_department :integer
#  accept_cert_date              :date
#  accept_cert_department        :integer
#  vendor_id                     :integer
#  amount                        :float
#  tax                           :float
#  discount_amount               :float
#  discount_tax                  :float
#  invoice_no                    :string(255)
#  invoice_date                  :date
#  created_at                    :datetime
#  updated_at                    :datetime
#

class RepairAcceptanceCertificate < ActiveRecord::Base
  has_many :repair_acceptance_certificate_lines
  belongs_to :vendor
  belongs_to :repair_requisition_department,
               :class_name => "Department",
               :foreign_key => "repair_requisition_department"
  belongs_to :accept_cert_department,
               :class_name => "Department",
               :foreign_key => "accept_cert_department"
  

  enum payment_location: { "banqiao" => 0, "taoyuan" => 1, "zhanghua" =>2}
  enum payment_type: {"draw_money"=>0, "send_ty_post"=>1}
end
