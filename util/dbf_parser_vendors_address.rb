require 'dbf'

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
  address = vendor.address 
  address1 = vendor.address1
  

  v = Vendor.find(sno)

  if (address != "")
    http = Curl.get("http://zip5.5432.tw/zip5json.py?adrs=" + address)
    zipcode = JSON.parse(http.body_str)["zipcode"]
  else
    zipcode = ""
  end

  address_type = 0
  if zipcode != ""
    country = "台灣"
  else
    country = ""
  end
  #ql = "INSERT INTO vendor_addresses ('building_and_street', 'zipcode', 'country'" +
  #      "'created_at','updated_at') VALUES" + 
  #      "(#{addresss},#{zipcode},#{country},'#{DateTime.now.to_s}','#{DateTime.now.to_s}')"
  #CONN.execute sql 
  va = VendorAddress.new(:building_and_street => address, :zipcode => zipcode, :country => country, :address_type => address_type)  
  va.vendor = v
  va.save

    #sql = "SELECT id FROM vendor_addresses where building_and_street = \"#{address}\""
  
  if (address1 != "")
    http = Curl.get("http://zip5.5432.tw/zip5json.py?adrs=" + address1)
    zipcode = JSON.parse(http.body_str)["zipcode"]
  else
    zipcode = ""   
  end
     
  if zipcode != ""
    country = "Taiwan"
  else
    country = ""
  end
  address_type = 1
  #ql = "INSERT INTO vendor_addresses ('building_and_street', 'zipcode', 'country'" +
  #      "'created_at','updated_at') VALUES" + 
  #      "(#{addresss},#{zipcode},#{country},'#{DateTime.now.to_s}','#{DateTime.now.to_s}')"
  #CONN.execute sql 
  va = VendorAddress.new(:building_and_street => address1, :zipcode => zipcode, :country => country, :address_type => address_type)
  va.vendor = v
  va.save

end

  #CONN.execute sql

#sql = "INSERT INTO vendors ('id', 'name', 'alias', 'pic_name', 'fax'," +
#      "'vat_id', 'product_type', 'main_business', 'payment_location', 'payment_type', 'payment_time'," +
#      "'check_usance', 'bank_id', 'bank_account_id', 'bank_account_name', 'receiver_vat_id'," +
#      "'notification_method', 'is_pay_for_wire_fee'," +
#      "'created_at','updated_at') VALUES #{inserts.join(", ")}"
