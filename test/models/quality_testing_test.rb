# == Schema Information
#
# Table name: quality_testings
#
#  id               :integer          not null, primary key
#  vendor_id        :integer          not null
#  test_date        :date             not null
#  spec             :string(255)      not null
#  lot_no           :string(255)
#  denier           :float            default(0.0)
#  strength         :float            default(0.0)
#  elongation       :float            default(0.0)
#  oil_content      :float            default(0.0)
#  shrinkage        :float            default(0.0)
#  entangling_value :integer          default(0)
#  cr_value         :float            default(0.0)
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
