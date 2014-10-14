class CreateQualityTestings < ActiveRecord::Migration
  def change
    create_table :quality_testings do |t|
      t.integer :vendor, null: false, index: true
      t.date :test_date, null: false, index: true
      t.string :spec, null: false, index: true
      t.string :lot_no
      t.float :denier
      t.float :strength
      t.float :elongation
      t.float :oil_content
      t.float :shrinkage
      t.integer :entangling_value
      t.float :cr_value
      t.text :note
      t.timestamps
    end
  end
end
