
def month_difference(end_date, start_date)
  year_diff = end_date.year - start_date.year
  month_diff = end_date.month - start_date.month

  if (month_diff < 0)
    year_diff = year_diff - 1
    month_diff = month_diff + 12
  end
  total_month = year_diff * 12 + month_diff
end

fas = Fixedasset.all
#status = ""
d84_date = DateTime.new(1996,12,31,0,0,0)
now_date = DateTime.now
fas.each do |f|
  if f.depreciation84 > 0
    if f.end_use_date < d84_date
      f.depreciated_value_per_month = 0
      f.depreciated_value_last_month = 0
    else

      f_reev = Fixedasset.joins(:fixedasset_changeds).
              select(
              :category_id,
              :evaluated_value,
              :evaluated_scrap_value,
              "fixedassets.department_id",
              :id).where("fixedassets.id = ? and fixedasset_changeds.change_type=3",f.id)

      reev = f_reev.first
      if (reev != nil)
        original_cost = reev.evaluated_value
        final_scrap_value = reev.evaluated_scrap_value
      else
        original_cost = f.original_cost
        final_scrap_value = (f.original_cost.to_f * 12 / (f.total_depreciated_month+12)).round
      end
      total_scrapped_value = original_cost - final_scrap_value
      remained_month = f.total_depreciated_month - month_difference(d84_date, f.start_use_date) -1

      if f.total_depreciated_month > 0
        f.depreciated_value_per_month = ((total_scrapped_value-f.depreciation84).to_f/remained_month).round
        f.depreciated_value_last_month = total_scrapped_value - f.depreciated_value_per_month*(remained_month-1) - f.depreciation84
      else
        f.depreciated_value_per_month = 0
        f.depreciated_value_last_month = 0
      end
    end
    f.save
  end
end
