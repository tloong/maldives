# == Schema Information
#
# Table name: purchasing_order_lineitems
#
#  id                           :integer          not null, primary key
#  purchasing_order_id          :integer
#  sequence_no                  :integer
#  material_id                  :integer
#  quantity                     :integer
#  purchased_unit_price         :float
#  amount                       :float
#  tax                          :float
#  purchasing_requisition_no    :string(255)
#  purchasing_requsition_seq_no :integer
#  purchasing_purpose           :string(255)
#  purchasing_requisition_date  :date
#  goods_need_date              :date
#  shipping_location            :integer
#  acceptance_certification_no  :integer
#  close_case                   :boolean
#  acc_type                     :integer
#  cost_department              :integer
#  created_at                   :datetime
#  updated_at                   :datetime
#

require 'test_helper'

class PurchasingOrderLineitemTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
