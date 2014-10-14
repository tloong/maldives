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

class QualityTesting < ActiveRecord::Base
  validates :vendor_id, presence: true
  validates :test_date, presence: true
  validates :lot_no, presence: true
  validates :spec, presence: true
  validates :denier, numericality: true, :format => { :with => /\A\d+(?:\.\d{0,2})?\z/ }, :allow_nil => true
  validates :strength, numericality: true, :format => { :with => /\A\d+(?:\.\d{0,2})?\z/ }, :allow_nil => true
  validates :elongation, numericality: true, :format => { :with => /\A\d+(?:\.\d{0,2})?\z/ }, :allow_nil => true
  validates :oil_content, numericality: true, :format => { :with => /\A\d+(?:\.\d{0,2})?\z/ }, :allow_nil => true
  validates :shrinkage, numericality: true, :format => { :with => /\A\d+(?:\.\d{0,2})?\z/ }, :allow_nil => true
  validates :entangling_value, numericality:  { only_integer: true }, :allow_nil => true
  validates :cr_value, numericality: true, :allow_nil => true

  belongs_to :vendor
end
