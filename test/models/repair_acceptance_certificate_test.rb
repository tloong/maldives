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

require 'test_helper'

class RepairAcceptanceCertificateTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
