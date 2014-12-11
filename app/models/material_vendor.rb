# == Schema Information
#
# Table name: material_vendors
#
#  id         :integer          not null, primary key
#  sno        :string(255)
#  name       :string(255)
#  sid        :string(255)
#  created_at :datetime
#  updated_at :datetime
#

class MaterialVendor < ActiveRecord::Base
	has_many :materials

	def to_label
   	 "#{sno.to_s.rjust(4,'0')} #{self.name}"
 	end
end
