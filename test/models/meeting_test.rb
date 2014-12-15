# == Schema Information
#
# Table name: meetings
#
#  id          :integer          not null, primary key
#  meetingname :string(255)
#  date        :date
#  created_at  :datetime
#  updated_at  :datetime
#

require 'test_helper'

class MeetingTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
