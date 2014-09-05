# == Schema Information
#
# Table name: fixedasset_changeds
#
#  id                    :integer          not null, primary key
#  fixedasset_id         :integer          not null
#  voucher_no            :integer
#  department_id         :integer
#  price                 :integer
#  changed_date          :date
#  username              :string(255)
#  reason                :text
#  note                  :text
#  created_at            :datetime
#  updated_at            :datetime
#  old_department_id     :integer
#  change_type           :integer
#  evaluated_value       :integer
#  evaluated_scrap_value :inetger
#

require 'test_helper'

class FixedassetChangedTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
