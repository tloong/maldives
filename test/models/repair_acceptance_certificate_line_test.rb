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

require 'test_helper'

class RepairAcceptanceCertificateLineTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
