require 'dbf'

CONN = ActiveRecord::Base.connection

vendors = DBF::Table.new("./util/MADER.DBF", nil, 'big5')
#widget = vendors.first
#puts widget.attributes

inserts = []
set = "SET sql_mode='NO_AUTO_VALUE_ON_ZERO'"
CONN.execute set
vendors.each do |vendor|
  sno  = vendor.sno

  if sno[0]=='B'
    sno[0] = '3'
  elsif sno[0] == 'P'
    sno[0] = '9'
  end

  sno = sno.to_i

  name = (vendor.name =="")? "NULL" : "\"#{vendor.name}\""
  name0 = (vendor.name0 =="")? "NULL" : "\"#{vendor.name0}\""
  name1 = (vendor.name1 =="")? "NULL" : "\"#{vendor.name1}\""
  #name2 = (vendor.name2 =="")? "NULL" : "'#{vendor.name2}'"
  fax   = (vendor.fax =="")? "NULL" : "\"#{vendor.fax}\""
  idno = (vendor.idno =="")? "NULL" : "\"#{vendor.idno}\""
  address = (vendor.address =="")? "NULL" : "\"#{vendor.address}\""
  kind = (vendor.kind =="")? "NULL" : "\"#{vendor.kind}\""
  mas_item = (vendor.mas_item =="")? "NULL" : "\"#{vendor.mas_item}\""
  
  case vendor.payfid 
  when 'T' 
    payfid = 1
  when 'P' 
    payfid = 2
  when 'F' 
    payfid = 3
  else
    payfid = 'NULL'
  end

  payid = (vendor.payid =="")? "NULL" : "#{vendor.payid}"
  paystat = (vendor.paystat =="")? "NULL" : "#{vendor.paystat}"
  check = (vendor.check =="")? "NULL" : "#{vendor.check}"
  bank_no = (vendor.bank_no =="")? "NULL" : "'#{vendor.bank_no}'"
  depo_no = (vendor.depo_no =="")? "NULL" : "'#{vendor.depo_no}'"
  name_d = (vendor.name_d =="")? "NULL" : "'#{vendor.name_d}'"
  depo_id = (vendor.depo_id =="")? "NULL" : "'#{vendor.depo_id}'"
  case vendor.notify
  when 'A'
    notify = 4
  when 'C' 
    notify = 5
  when 1..10
    notify = vendor.notify
  else
    notify = 'NULL'
  end

  #email = (vendor.email =="")? "NULL" : "'#{vendor.email}'"
  #remark = (vendor.remark =="")? "NULL" : "'#{vendor.remark}'"
  pay30 = (vendor.pay30 =="")? "NULL" : "'#{vendor.pay30}'"
  
  sql = "INSERT INTO vendors (`id`, `name`, `alias`, `pic_name`, `fax`," +
      "`vat_id`, `product_type`, `main_business`, `payment_location`, `payment_type`, `payment_time`," +
      "`check_usance`, `bank_id`, `bank_account_id`, `bank_account_name`, `receipter_vat_id`," +
      "`notification_method`, `is_pay_for_wire_fee`," +
      "`created_at`,`updated_at`) VALUES" + 
      "(#{sno},#{name},#{name0},#{name1},#{fax},#{idno},#{kind},#{mas_item},#{payfid}, #{payid}, #{paystat},#{check},#{bank_no},#{depo_no}, #{name_d},#{depo_id},#{notify},#{pay30},'#{DateTime.now.to_s(:db)}','#{DateTime.now.to_s(:db)}')"

  CONN.execute sql
end

#sql = "INSERT INTO vendors ('id', 'name', 'alias', 'pic_name', 'fax'," +
#      "'vat_id', 'product_type', 'main_business', 'payment_location', 'payment_type', 'payment_time'," +
#      "'check_usance', 'bank_id', 'bank_account_id', 'bank_account_name', 'receiver_vat_id'," +
#      "'notification_method', 'is_pay_for_wire_fee'," +
#      "'created_at','updated_at') VALUES #{inserts.join(", ")}"
