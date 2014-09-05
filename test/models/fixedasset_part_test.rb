# == Schema Information
#
# Table name: fixedasset_parts
#
#  id            :integer          not null, primary key
#  part_no       :integer
#  department_id :integer
#  weight        :float            default(0.0)
#  created_at    :datetime
#  updated_at    :datetime
#

require 'test_helper'

class FixedassetPartTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
