module FixedassetsHelper
  def get_department_depid_and_alias(id)
    d = Department.find(id)
    return "#{d.dep_id} #{d.alias}"
  end

  def get_department_id(depno)
    case depno
    when '0000'
      department_id = 120
    when '1261'
      department_id = 67
    when '2260'
      department_id = 75
    when '2261'
      department_id = 76
    when '2262'
      department_id = 77
    when '2263'
      department_id = 78
    when '2264'
      department_id = 79
    when '2265'
      department_id = 80
    when '2266'
      department_id = 81
    when '2267'
      department_id = 82
    when '2268'
      department_id = 83
    when '2269'
      department_id = 84
    when '2271'
      department_id = 86
    when '2272'
      department_id = 99
    when '3261'
      department_id = 87
    when '226A'
      department_id = 91
    end

    return department_id
  end

  def month_difference(end_date, start_date)
    (end_date.year * 12 + end_date.month) - (start_date.year * 12 + start_date.month)
    #ear_diff = end_date.year - start_date.year
    #month_diff = end_date.month - start_date.month

    #if (month_diff < 0)
    #  year_diff = year_diff - 1
    #  month_diff = month_diff + 12
    #end
    #total_month = year_diff * 12 + month_diff
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


end
