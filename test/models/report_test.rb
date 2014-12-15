# == Schema Information
#
# Table name: reports
#
#  id             :integer          not null, primary key
#  meeting_id     :integer
#  name           :string(255)
#  module         :text
#  this_week_work :text
#  need_help      :text
#  next_week_work :text
#  share_tech     :text
#  created_at     :datetime
#  updated_at     :datetime
#

require 'test_helper'

class ReportTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
