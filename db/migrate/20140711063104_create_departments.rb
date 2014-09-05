class CreateDepartments < ActiveRecord::Migration
  def change
    create_table :departments do |t|
      t.string :department_id, null: false, index: true
      t.string :name, null: false
      t.string :alias
      t.string :docket_head
      t.integer :account_type
      t.timestamps
    end
  end
end
