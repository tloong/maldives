require 'dbf'

def get_department_id(depno)
  d = Department.find_by_dep_id(depno)
  return d.id
end


CONN = ActiveRecord::Base.connection

vendors = DBF::Table.new("./util/FIXPART.DBF", nil, 'big5')
#widget = vendors.first
#puts widget.attributes

i = 0
vendors.each do |vendor|
  
  if (vendor == nil )
    puts "depart[#{i+2}]: passed, need to modify"
    i = i + 1
    next
  end
  fp = FixedassetPart.new
  
  case vendor.part
  when '1'
    d_id = "1261"
  when '2'
    d_id = "0000"
  when '3'
    d_id = "0000"
  end
  puts "#{vendor.depno}|d_id=#{get_department_id(d_id)}|refed_id=#{get_department_id(vendor.depno)}"
  fp.refed_department_id = get_department_id(vendor.depno)
  fp.department_id = get_department_id(d_id)
  fp.weight = vendor.weight
  fp.part_no = vendor.part.to_i 
  fp.save
end

#sql = "INSERT INTO vendors ('id', 'name', 'alias', 'pic_name', 'fax'," +
#      "'vat_id', 'product_type', 'main_business', 'payment_location', 'payment_type', 'payment_time'," +
#      "'check_usance', 'bank_id', 'bank_account_id', 'bank_account_name', 'receiver_vat_id'," +
#      "'notification_method', 'is_pay_for_wire_fee'," +
#      "'created_at','updated_at') VALUES #{inserts.join(", ")}"
