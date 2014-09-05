class CreateFixedassetParts < ActiveRecord::Migration
  def change
    create_table :fixedasset_parts do |t|
      t.integer :part_no
      t.integer :department_id
      t.float :weight, default: 0.0
      t.timestamps
    end
  end
end
