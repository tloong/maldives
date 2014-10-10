# == Schema Information
#
# Table name: departments
#
#  id           :integer          not null, primary key
#  dep_id       :string(255)      not null
#  name         :string(255)      not null
#  alias        :string(255)
#  docket_head  :string(255)
#  account_type :integer
#  created_at   :datetime
#  updated_at   :datetime
#

class Department < ActiveRecord::Base
#   has_many :fixedassets
#   has_many :fixedasset_parts
#   
#   accepts_nested_attributes_for :fixedasset_parts

   def to_label
     "#{dep_id}: #{self.alias}"
   end

self.per_page = 20

end 

