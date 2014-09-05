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

class FixedassetChanged < ActiveRecord::Base
  belongs_to :fixedasset
  belongs_to :department
  belongs_to :old_department,
             :class_name => "Department",
             :foreign_key => "old_department_id"

  enum change_type: { "transfer" => 0, "depreciation" => 1, "sold"=>2, "reevaluation" =>3}

end
