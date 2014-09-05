
def month_difference(end_date, start_date)
  year_diff = end_date.year - start_date.year
  month_diff = end_date.month - start_date.month

  if (month_diff < 0)
    year_diff = year_diff - 1
    month_diff = month_diff + 12
  end
  total_month = year_diff * 12 + month_diff
end
d84_date = DateTime.new(1996,12,31,0,0,0)
now_date = DateTime.now
fixedasset_changeds = FixedassetChanged.where('change_type=?',3)
fixedasset_changeds.each do |fcc|
  f = Fixedasset.find(fcc.fixedasset_id)
  if (f == nil )
    puts "fixedasset_id[#{fcc.fixedasset_id}] not found"
    next
  end 

  if f.depreciation84 > 0
    if f.end_use_date < d84_date
      f.accumulated_depreciated_value = f.depreciation84
      f.depreciated_value_per_month = 0
      f.depreciated_value_last_month = 0
    else
      final_scrap_value = fcc.evaluated_scrap_value
      total_scrapped_value = fcc.evaluated_value - final_scrap_value
      remained_month = f.total_depreciated_month - month_difference(d84_date, f.start_use_date) -1

      if f.total_depreciated_month > 0
        f.depreciated_value_per_month = ((total_scrapped_value-f.depreciation84).to_f/remained_month).round
        f.depreciated_value_last_month = total_scrapped_value - f.depreciated_value_per_month*(remained_month) - f.depreciation84
        if (now_date > f.end_use_date) || (now_date.month == f.end_use_date.month && now_date.year == f.end_use_date.year)
          #status = "end"
          f.accumulated_depreciated_value = f.original_cost - final_scrap_value
        else
          ##status = "ongoing"
          #puts "original_cost:#{f.original_cost},total_dep_month:#{f.total_depreciated_month}remained_month:#{remained_month}, final_scrap_value:#{final_scrap_value}"

          f.accumulated_depreciated_value = f.depreciated_value_per_month * month_difference(now_date,d84_date)
          #puts "#{f.original_cost - accumulated_depreciated_value-f.depreciation84}:#{f.depreciated_value_per_month}:#{month_difference(now_date,d84_date)}"
        end
      else
        f.depreciated_value_per_month = 0
        f.depreciated_value_last_month = 0
      end
    end
    #puts "[#{f.fixed_asset_id}][#{#status}], d84:#{f.depreciation84}, scrap_value:#{f.original_cost - f.accumulated_depreciated_value}, d_per_month:#{f.depreciated_value_per_month}, d_last_month:#{f.depreciated_value_last_month}"
    f.update_value_date = DateTime.now
    f.save
  end
end

