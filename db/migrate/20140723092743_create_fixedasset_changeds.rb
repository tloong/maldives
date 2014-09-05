class CreateFixedassetChangeds < ActiveRecord::Migration
  def change
    create_table :fixedasset_changeds do |t|
      t.integer :fixedasset_id, null: false, index: true
      t.integer :voucher_no
      t.integer :department_id
      t.integer :price
      t.date :changed_date
      t.string :username
      t.text :reason
      t.text :note
      t.timestamps
    end
  end
end
