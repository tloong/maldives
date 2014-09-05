# == Schema Information
#
# Table name: fixedasset_legacy_infos
#
#  id                             :integer          not null, primary key
#  fixedasset_id                  :integer
#  revaluated_value               :float
#  revaluated_scrap_value         :float
#  revaluated_date                :date
#  redepreciated_value            :float
#  redepreciated_scrap_value      :float
#  redepreciated_date             :date
#  redepreciated_start_date       :date
#  redepreciated_end_date         :date
#  redepreciated_price_per_month  :float
#  redepreciated_price_last_month :float
#  end_price                      :float
#  end_date                       :date
#  created_at                     :datetime
#  updated_at                     :datetime
#

class FixedassetLegacyInfo < ActiveRecord::Base
end
