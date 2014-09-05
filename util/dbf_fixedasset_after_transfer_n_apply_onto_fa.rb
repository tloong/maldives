require 'dbf'

def get_deparment_id (dep_id) 
  case dep_id
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


CONN = ActiveRecord::Base.connection

fixedassets = DBF::Table.new("./util/FIXMOVE.DBF", nil, 'big5')

inserts = []
puts "total count:" + fixedassets.count.to_s
i = 0
fixedassets.each do |f|
  if (f == nil )
    puts "fixedasset_id[#{i+2}]: passed, need to modify"
    i = i + 1
    next
  end
  if (f.type == "L")
    #puts "fixedasset_id[#{i+2}]: due to type L"
    i = i + 1
    next
  end
  fixno  = f.fixno  
  fixed_asset = Fixedasset.find_by_fixed_asset_id(fixno) 
  if (fixed_asset == nil )
    puts "#{fixno} cannot be found" + i.to_s
    i = i+1
    next
  end

  puts "fixedasset_id[#{i}]: #{fixno.to_s}"
  i = i +1
  type = f.type
  
  # prepare data 
  voucher_no = f.chno  
  old_department_id = get_deparment_id(f.depno1)
  new_department_id = get_deparment_id(f.depno2)

  fixed_asset.update_attributes :department_id => new_department_id
  puts "update from #{old_department_id} to #{new_department_id}"
  
  
end

#sql = "INSERT INTO vendors ('id', 'name', 'alias', 'pic_name', 'fax'," +
#      "'vat_id', 'product_type', 'main_business', 'payment_location', 'payment_type', 'payment_time'," +
#      "'check_usance', 'bank_id', 'bank_account_id', 'bank_account_name', 'receiver_vat_id'," +
#      "'notification_method', 'is_pay_for_wire_fee'," +
#      "'created_at','updated_at') VALUES #{inserts.join(", ")}"
