module FixedassetsHelper

  def get_department_depid_and_alias(id)
    d = Department.find(id)
    return "#{d.dep_id} #{d.alias}"
  end

  def get_department_id(depno)
    d = Department.find_by_dep_id(depno)
    return d.id
  end

  def get_base_fixedasset(fixed_asset_id)
    tmp_id = "#{fixed_asset_id}"
    tmp_id[9]="0"
    tmp_id[10]="0"
    return Fixedasset.find_by_fixed_asset_id(tmp_id)
  end

  def create_redepreciations_according_to_base_asset(fixed_asset_id,start_use_date)
    self_fixedasset = Fixedasset.find_by_fixed_asset_id(fixed_asset_id)
    base_fixedasset = get_base_fixedasset(fixed_asset_id)
    
    redep = base_fixedasset.fixedasset_redepreciation
    if redep != nil
      months  = month_difference(redep.re_end_use_date,start_use_date) + 1
      if (months > 0)
        rd = FixedassetRedepreciation.new
        rd.re_original_value = self_fixedasset.original_cost
        rd.re_final_scrap_value = (self_fixedasset.original_cost.to_f*months/(months+12)).round
        
        if (months == 1)
          rd.re_depreciated_value_per_month = 0
          rd.re_depreciated_value_last_month = rd.re_original_value - rd.re_final_scrap_value
        else
          rd.re_depreciated_value_per_month = ((rd.re_original_value - rd.re_final_scrap_value).to_f / months).round
          rd.re_depreciated_value_last_month = rd.re_original_value - rd.re_final_scrap_value - (rd.re_depreciated_value_per_month*(months-1))
        end

        rd.re_start_use_date = start_use_date 
        rd.re_end_use_date = start_use_date + (months-1).month
        rd.fixedasset_id = self_fixedasset.id
        rd.save
      end
    end
  end

  def get_correct_service_life(fixed_asset_id,start_use_date)
    base_fixedasset = get_base_fixedasset(fixed_asset_id)
    
    service_life_year = 0
    service_life_month = 0
    # if 00 is end, then return 0,0
    # else retuen 00's end_use_date - self.start_use_date + 1.month
    if Date.today <= base_fixedasset.end_use_date
      service_life_year, service_life_month  = date1_sub_date2_difference(base_fixedasset.end_use_date,start_use_date)
      service_life_month = service_life_month + 1
    end
    
    return service_life_year, service_life_month
    end

  def date1_sub_date2_difference(date1, date2)
    md = month_difference(date1,date2)
    return md/12, md%12
  end

  def month_difference(end_date, start_date)
    (end_date.year * 12 + end_date.month) - (start_date.year * 12 + start_date.month)
  end

  def get_end_date (end_date, redep)
    e_date = end_date
    if redep != nil
      if (end_date > redep.re_start_use_date)
        e_date = redep.re_start_use_date - 1.month
      end
    end
    return e_date
  end

  def is_scraped_how_many_month (service_life_year, service_life_month, start_use_date) 
    total_month = service_life_month + service_life_year*12
    end_use_date =  start_use_date + total_month.month 

    if DateTime.now > end_use_date
      total_month
    else
      month_difference(DateTime.now,start_use_date)
    end
  end

  def check_fixedasset_params(f_params,f_keys)
    return_code = Fixedasset::NO_ERROR
    f_keys.each do |key|
      if (f_params[key].blank?)
        return_code =  Fixedasset::PARAMS_BLANK
      end
    end
    
    return return_code
  end


end
