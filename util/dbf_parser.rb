require 'dbf'

CONN = ActiveRecord::Base.connection

widgets = DBF::Table.new("./util/DEPART.DBF", nil, 'big5')
#widget = widgets.first
#puts widget.attributes

inserts = []
widgets.each do |record|
  dep_id = (record.dep_id =="")? "'NULL'" : "'#{record.dep_id}'"
  account_type = (record.pay_id=="")? "NULL" : record.pay_id
  inserts.push "('#{record.dep_no}','#{record.name}','#{record.name0}',#{dep_id},#{account_type},'#{DateTime.now.to_s}','#{DateTime.now.to_s}')"
end

sql = "INSERT INTO departments ('department_id', 'name', 'alias', 'docket_head', 'account_type','created_at','updated_at') VALUES #{inserts.join(", ")}"
CONN.execute sql