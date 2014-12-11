# == Schema Information
#
# Table name: material_cat_lv2s
#
#  id         :integer          not null, primary key
#  cat_id     :string(255)
#  cat_name   :string(255)
#  created_at :datetime
#  updated_at :datetime
#

class MaterialCatLv2 < ActiveRecord::Base
	has_many :materials

	def to_label
   	 "#{cat_id.to_s.rjust(4,'0')} #{self.cat_name}"
 	end
end
