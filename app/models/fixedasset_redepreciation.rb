# == Schema Information
#
# Table name: fixedasset_redepreciations
#
#  id                               :integer          not null, primary key
#  fixedasset_id                    :string(255)      not null
#  re_original_value                :integer
#  re_final_scrap_value             :integer
#  re_depreciated_value_per_month   :integer
#  re_depreciated_value_last_month  :integer
#  re_accumulated_depreciated_value :integer
#  re_start_use_date                :date
#  re_update_value_date             :date
#  created_at                       :datetime
#  updated_at                       :datetime
#  re_depreciated_value_this_year   :integer
#  re_end_use_date                  :date
#

class FixedassetRedepreciation < ActiveRecord::Base
belongs_to :fixedasset



end
