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

require 'test_helper'

class DepartmentTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
