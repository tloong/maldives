require 'dbf'

def get_department_id(depno)
  d = Department.find_by_dep_id(depno)
  return d.id
end

def month_difference(end_date, start_date)
  year_diff = end_date.year - start_date.year
  month_diff = end_date.month - start_date.month

  if (month_diff < 0)
    year_diff = year_diff - 1
    month_diff = month_diff + 12
  end
  total_month = year_diff * 12 + month_diff
end

CONN = ActiveRecord::Base.connection

fixedassets = DBF::Table.new("./util/FIXIN.DBF", nil, 'big5')

inserts = []
puts "total count:" + fixedassets.count.to_s
i = 0
fixedassets.each do |f|
  
  fixno  = f.fixno  
  #puts "fixedasset_id[#{i}]: #{fixno.to_s}"
  i = i +1
  ab_type = fixno[0]
  tyear = fixno[1..2].to_i
  category_id = fixno[3].to_i
  category_lv2 = fixno[4]
  serial_no = fixno[5..7].to_i
  sequence_no = fixno[9..10].to_i

  voucher_no = f.chno
  name = f.fixna0
  spec = f.fixna1
  quantity = f.qty
  unit = f.um
  original_cost = f.tcost
  username = f.user
  depreciation84 = f.damp84
  
  service_life_year = f.dyear
  service_life_month = f.dmonth

  department_id = get_department_id(f.depno)

  vendor_id = f.fno.to_i
  note = f.ps
  use_date = f.date
  year = use_date[0..2].to_i + 1911
  month = use_date[3..4].to_i
  day = use_date[5..6].to_i

  get_date = DateTime.new(year,month,day,0,0,0)
  if day > 15
    if (month == 12)
      month = 1
      year = year + 1
    else
      month = month + 1
    end
  end
  day = 1 
  start_use_date = DateTime.new(year,month,day,0,0,0)
  end_use_date = start_use_date + service_life_year.year + service_life_month.month - 1.month
  end_extend_date = end_use_date + 3.years - 1.month
  now_date = DateTime.now
  
  total_depreciated_month = (service_life_year*12) + service_life_month
  final_scrap_value = ((original_cost * 12).to_f / (total_depreciated_month+12)).round
  total_depreciated_price = original_cost - final_scrap_value
  if (total_depreciated_month==0)
    depreciated_value_per_month = 0
    depreciated_value_last_month = 0
  else
    depreciated_value_per_month  = (total_depreciated_price / total_depreciated_month).round
    depreciated_value_last_month = total_depreciated_price - (depreciated_value_per_month*(total_depreciated_month-1))
  end
  
  if now_date > end_use_date
    status = 2 # depreciation_done
  else
    status = 0 # in_use
  end
  
  record_date = f.usedate

  fa = Fixedasset.new
  fa.final_scrap_value = final_scrap_value
  fa.fixed_asset_id = fixno
  fa.ab_type = ab_type
  fa.year = tyear
  fa.category_id = category_id
  fa.category_lv2 = category_lv2
  fa.serial_no = serial_no
  fa.sequence_no = sequence_no
  fa.voucher_no = voucher_no
  fa.name = name
  fa.spec = spec
  fa.quantity = quantity
  fa.unit = unit
  fa.original_cost = original_cost
  fa.get_date = get_date
  fa.service_life_month = service_life_month
  fa.service_life_year = service_life_year
  fa.depreciated_value_per_month = depreciated_value_per_month
  fa.depreciated_value_last_month = depreciated_value_last_month
  fa.accumulated_depreciated_value = accumulated_depreciated_value
  fa.department_id = department_id
  fa.vendor_id = vendor_id
  fa.status = status
  fa.start_use_date =  start_use_date
  fa.end_use_date = end_use_date
  fa.note = note
  fa.username = username.downcase
  fa.depreciation84 = depreciation84
  if (!record_date.blank?)
    year = record_date[0..2].to_i + 1911
    month = record_date[3..4].to_i
    day = record_date[5..6].to_i

    record_date = DateTime.new(year,month,day,0,0,0)
    fa.created_at = record_date
  end
  
  if (f.fixset == "1")
    fa.is_mortgaged = true
  else
    fa.is_mortgaged = false
  end

  fa.save!
end

#sql = "INSERT INTO vendors ('id', 'name', 'alias', 'pic_name', 'fax'," +
#      "'vat_id', 'product_type', 'main_business', 'payment_location', 'payment_type', 'payment_time'," +
#      "'check_usance', 'bank_id', 'bank_account_id', 'bank_account_name', 'receiver_vat_id'," +
#      "'notification_method', 'is_pay_for_wire_fee'," +
#      "'created_at','updated_at') VALUES #{inserts.join(", ")}"
