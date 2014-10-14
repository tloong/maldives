class ModifyNameOfQualityTesting < ActiveRecord::Migration
  def change
    rename_column :quality_testings, :vendor, :vendor_id
  end
end
