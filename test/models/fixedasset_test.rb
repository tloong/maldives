# == Schema Information
#
# Table name: fixedassets
#
#  id                            :integer          not null, primary key
#  fixed_asset_id                :string(255)      not null
#  ab_type                       :string(255)      not null
#  year                          :integer          not null
#  category_lv1                  :integer          not null
#  category_lv2                  :string(255)      not null
#  serial_no                     :integer          not null
#  sequence_no                   :integer          not null
#  voucher_no                    :integer
#  name                          :string(255)      not null
#  spec                          :text
#  quantity                      :integer          default(0), not null
#  unit                          :string(255)
#  original_cost                 :integer
#  get_date                      :date
#  service_life_year             :integer
#  service_life_month            :integer
#  depreciated_value_per_month   :integer
#  depreciated_value_last_month  :integer
#  accumulated_depreciated_value :integer
#  department_id                 :integer
#  vendor_id                     :integer
#  status                        :integer
#  note                          :text
#  start_use_date                :date
#  created_at                    :datetime
#  updated_at                    :datetime
#  username                      :string(255)
#  depreciation84                :integer
#  update_value_date             :date
#  final_scrap_value             :integer
#  depreciated_value_this_year   :integer
#  is_mortgaged                  :boolean
#

require 'test_helper'

class FixedassetTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
