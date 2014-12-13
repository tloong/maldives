
# == Schema Information
#
# Table name: acceptance_certifications
#
# id           	    :integer          not null, primary key
# accept_cert_no	  :string   		    not null, primary key
# accept_cert_date	:date
# currency			    :integer
# exchange_rate		  :float
# amount 			      :float
# tax       				:float
# discount_amount 	:float
# discount_tax   		:float
# invoice_no 		    :string
# invoice_date 		  :date
# note_for_payment 	:text
# voucher_no 		    :string
# voucher_date 		  :date
# acc_type 			    :integer
# vendor_id 		    :integer
# created_at        :datetime
# updated_at        :datetime
# user_id           :integer
#

class AcceptanceCertification < ActiveRecord::Base
	has_many :acceptance_lineitems, :dependent => :destroy
	belongs_to :vendor
  belongs_to :department
  belongs_to :owner, :class_name => "User", :foreign_key => :user_id

	validates :accept_cert_no, presence: true
     
  accepts_nested_attributes_for :acceptance_lineitems, 
    :reject_if => proc {|attributes| attributes['received_quantity'].blank?}, 
    allow_destroy: true

  self.per_page = 20

	enum acc_type: { "sale" => 0, "manager" => 1, "d_labor" => 2, "nd_labor" => 3}

	def to_label
    	"#{id.to_s.rjust(4,'0')} #{self.alias}"
  end  	
end


