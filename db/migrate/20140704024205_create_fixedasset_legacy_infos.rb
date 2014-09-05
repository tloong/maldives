class CreateFixedassetLegacyInfos < ActiveRecord::Migration
  def change
    create_table :fixedasset_legacy_infos do |t|
      # 屬於 fixed asset
      t.belongs_to :fixedasset
      
      # 重估資料
      t.float :revaluated_value
      t.float :revaluated_scrap_value
      t.date  :revaluated_date

      # 續提折舊資料
      t.float :redepreciated_value
      t.float :redepreciated_scrap_value
      t.date  :redepreciated_date 
      t.date  :redepreciated_start_date
      t.date  :redepreciated_end_date
      t.float :redepreciated_price_per_month
      t.float :redepreciated_price_last_month

      # 出售/報廢資料
      t.float :end_price
      t.date  :end_date

      t.timestamps
    end
  end
end
