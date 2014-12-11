# == Schema Information
#
# Table name: materials
#
#  id                  :integer          not null, primary key
#  mat_id              :string(255)
#  vendor_lot_no       :string(255)
#  material_cat_lv1_id :integer
#  material_cat_lv2_id :integer
#  name                :string(255)
#  condition_id        :string(255)
#  description         :text
#  note                :text
#  accounting_type     :integer
#  debit_code          :integer
#  credit_code         :integer
#  is_shared_id        :boolean
#  is_quantity_control :boolean
#  is_sample           :boolean
#  measure_unit        :string(255)
#  vendor_id           :string(255)
#  created_at          :datetime
#  updated_at          :datetime
#  safe_quantity       :integer
#  stocktake_quantity  :integer
#  last_quantity       :integer
#  total_quantity      :integer
#  sno                 :string(255)
#

require 'test_helper'

class MaterialTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
