# == Schema Information
#
# Table name: acceptance_lineitems
#
# id           	   			 	:integer          not null, primary key
# acceptance_certification_id	:integer		  not null, primary key	
# purchasing_order_lineitem_id	:integer
# received_quantity				:float
# accepted_quantity				:float
# ng_quantity 					:float
# unit_price 					:float
# total_amount 					:float
# tax 							:float
# discount_amount 				:float
# discount_tax					:float
# received_department_id		:integer
# acc_type 						:integer
# cost_department_id			:integer
# special_flag					:integer
# created_at				    :datetime
# updated_at        			:datetime
# material_id					:integer
#

class AcceptanceLineitem < ActiveRecord::Base
	belongs_to :acceptance_certification
	belongs_to :material
	belongs_to :received_department,
   	           :class_name => "Department",
               :foreign_key => "received_department_id"
  belongs_to :cost_department,
   	           :class_name => "Department",
               :foreign_key => "cost_department_id"

	enum acc_type: { "sale" => 0, "manager" => 1, "d_labor" => 2, "nd_labor" => 3}
	enum special_flag: { "tlvn" => 1, "sarah" => 2}
  
end

