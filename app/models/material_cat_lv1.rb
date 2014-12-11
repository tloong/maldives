class MaterialCatLv1 < ActiveRecord::Base
	has_many :materials

	def to_label
   	 "#{cat_id.to_s.rjust(1,'0')} #{self.cat_name}"
 	end
end
