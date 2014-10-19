class AddDefaultValue < ActiveRecord::Migration
  def change
    change_column :quality_testings, :denier, :float, :default => 0
    change_column :quality_testings, :strength, :float, :default => 0
    change_column :quality_testings, :elongation, :float, :default => 0
    change_column :quality_testings, :oil_content, :float, :default => 0
    change_column :quality_testings, :shrinkage, :float, :default => 0
    change_column :quality_testings, :entangling_value, :integer, :default => 0
    change_column :quality_testings, :cr_value, :float, :default => 0
  end
end
