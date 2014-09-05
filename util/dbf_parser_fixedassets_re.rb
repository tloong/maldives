require 'dbf'
CONN = ActiveRecord::Base.connection

fixedassets = DBF::Table.new("./util/FIXRE.DBF", nil, 'big5')

inserts = []
puts "total count:" + fixedassets.count.to_s
i = 0
fixedassets.each do |f|
  if (f == nil )
    puts "fixedasset_id[#{i+2}]: passed, need to modify"
    i = i + 1
    next
  end
  if (f.type != "R")
    #puts "fixedasset_id[#{i+2}]: due to type L"
    i = i + 1
    next
  end
  fixno  = f.fixno  
  fixed_asset = Fixedasset.find_by_fixed_asset_id(fixno) 
  if (fixed_asset == nil )
    puts "#{fixno} cannot be found" + (i+2).to_s
    i = i+1
    next
  end

  #puts "fixedasset_id[#{i}]: #{fixno.to_s}"
  i = i +1
  type = f.type
  
  # prepare data 
  fc = FixedassetChanged.new
  fc.fixedasset_id = fixed_asset.id
  date_to_change = f.date
  if (!date_to_change.blank?)
    year = date_to_change[0..2].to_i + 1911
    month = date_to_change[3..4].to_i
    day = date_to_change[5..6].to_i
    log_date = DateTime.new(year,month,day,0,0,0)    
    fc.changed_date = log_date
  end  
  
  fc.username = f.user.downcase
  fc.evaluated_value = f.rcost.to_i
  fc.evaluated_scrap_value = f.rrest.to_i
  use_date = f.usedate
  if (!use_date.blank?)
    year = use_date[0..2].to_i + 1911
    month = use_date[3..4].to_i
    day = use_date[5..6].to_i
    log_date = DateTime.new(year,month,day,0,0,0)    
    fc.created_at = log_date
  end  
  
  if f.type =="R"
    fc.change_type = 3
  end
  fc.save! 
end

#sql = "INSERT INTO vendors ('id', 'name', 'alias', 'pic_name', 'fax'," +
#      "'vat_id', 'product_type', 'main_business', 'payment_location', 'payment_type', 'payment_time'," +
#      "'check_usance', 'bank_id', 'bank_account_id', 'bank_account_name', 'receiver_vat_id'," +
#      "'notification_method', 'is_pay_for_wire_fee'," +
#      "'created_at','updated_at') VALUES #{inserts.join(", ")}"
