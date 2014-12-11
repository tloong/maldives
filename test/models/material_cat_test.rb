# == Schema Information
#
# Table name: material_cats
#
#  id         :integer          not null, primary key
#  lv2        :string(255)
#  cat_id     :string(255)
#  cat_name   :string(255)
#  created_at :datetime
#  updated_at :datetime
#

require 'test_helper'

class MaterialCatTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
