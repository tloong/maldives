# == Schema Information
#
# Table name: quality_testings
#
#  id               :integer          not null, primary key
#  vendor           :integer          not null
#  test_date        :date             not null
#  spec             :text             not null
#  lot_no           :string(255)
#  denier           :float
#  strength         :float
#  elongation       :float
#  oil_content      :float
#  shrinkage        :float
#  entangling_value :integer
#  cr_value         :float
#  note             :text
#  created_at       :datetime
#  updated_at       :datetime
#

require 'test_helper'

class QualityTestingTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
