require 'dbf'
require 'ValidateEmail'

CONN = ActiveRecord::Base.connection

vendors = DBF::Table.new("./util/MADER.DBF", nil, 'big5')
#widget = vendors.first
#puts widget.attributes

inserts = []
i = 0
vendors.each do |vendor|
  sno  = vendor.sno

  if sno[0]=='B'
    sno[0] = '3'
  elsif sno[0] == 'P'
    sno[0] = '9'
  end

  sno = sno.to_i
  
  v = Vendor.find(sno)

  if (VendorContact.find_by_vendor_id(v.id) != nil)
    puts "id = #{v.id}, sno = #{sno}, pass:"+ i.to_s
    i = i+1
    next
  end
  
  name = vendor.name2 
  phone = vendor.tel1 
  phone2 = vendor.tel2 
  phone3 = vendor.tel3 
  email = (ValidateEmail.validate(vendor.email))? vendor.email : ""


  if (name == "" and phone == "" and phone2 == "" and phone3 == "" and email =="")
    puts "pass:"+ i.to_s
    i = i+1
    next
  else
    vc = VendorContact.new
    vc.vendor = v
    vc.name = name
    vc.phone = phone
    vc.phone2 = phone2
    vc.phone3 = phone3
    vc.email = email
    vc.save
  end

end

#sql = "INSERT INTO vendors ('id', 'name', 'alias', 'pic_name', 'fax'," +
#      "'vat_id', 'product_type', 'main_business', 'payment_location', 'payment_type', 'payment_time'," +
#      "'check_usance', 'bank_id', 'bank_account_id', 'bank_account_name', 'receiver_vat_id'," +
#      "'notification_method', 'is_pay_for_wire_fee'," +
#      "'created_at','updated_at') VALUES #{inserts.join(", ")}"
