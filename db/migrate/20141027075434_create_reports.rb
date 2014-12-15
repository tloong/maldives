class CreateReports < ActiveRecord::Migration
  def change
    create_table :reports do |t|
      t.integer :meeting_id
      t.string :name
      t.text :module
      t.text :this_week_work
      t.text :need_help
      t.text :next_week_work
      t.text :share_tech

      t.timestamps
    end
  end
end
