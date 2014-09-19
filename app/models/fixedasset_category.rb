# == Schema Information
#
# Table name: fixedasset_categories
#
#  id         :integer          not null, primary key
#  cat_id     :string(255)      not null
#  cat_name   :string(255)      not null
#  created_at :datetime
#  updated_at :datetime
#

class FixedassetCategory < ActiveRecord::Base
end
