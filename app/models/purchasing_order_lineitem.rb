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

class PurchasingOrderLineitem < ActiveRecord::Base
    belongs_to :purchasing_order
#   belongs_to :department
    belongs_to :cost_department,
               :class_name => "Department",
               :foreign_key => "cost_department"

    enum shipping_location: { "banqiao" => 0, "taoyuan" => 1, "zhanghua" =>2}
    enum acc_type: { "sale" => 0, "manager" => 1, "d_labor" => 2, "nd_labor" => 3}
end                             
