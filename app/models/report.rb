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

class Report < ActiveRecord::Base
  belongs_to :meeting
end
