require 'dbf'

CONN = ActiveRecord::Base.connection

fixedassets = DBF::Table.new("./util/FIXSUB.DBF", nil, 'big5')

puts "total count:" + fixedassets.count.to_s

fixedassets.each do |f|
  cat_id = f.subno
  cat_name = f.subna
  fc = FixedassetCategory.new
  fc.cat_id = cat_id
  fc.cat_name = cat_name
  fc.save!
end

#sql = "INSERT INTO vendors ('id', 'name', 'alias', 'pic_name', 'fax'," +
#      "'vat_id', 'product_type', 'main_business', 'payment_location', 'payment_type', 'payment_time'," +
#      "'check_usance', 'bank_id', 'bank_account_id', 'bank_account_name', 'receiver_vat_id'," +
#      "'notification_method', 'is_pay_for_wire_fee'," +
#      "'created_at','updated_at') VALUES #{inserts.join(", ")}"
