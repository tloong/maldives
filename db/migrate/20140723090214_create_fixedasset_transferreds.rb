class CreateFixedassetTransferreds < ActiveRecord::Migration
  def change
    create_table :fixedasset_transferreds do |t|
      t.integer :fixedasset_id, index: true
      t.integer :department_id 
      t.integer :original_department_id
      t.timestamps
    end
  end
end
