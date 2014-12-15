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

class Meeting < ActiveRecord::Base
   has_many :reports
   validates :name, :presence => true
  def name_with_initial
    meetingname
  end
end
