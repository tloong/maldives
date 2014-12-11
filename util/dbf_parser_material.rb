require 'dbf'

CONN = ActiveRecord::Base.connection

widgets = DBF::Table.new("./util/MATMAS.DBF", nil, 'big5')
#widget = widgets.first
#puts widget.attributes

inserts = []
widgets.each do |record|
  # dep_id = (record.dep_id =="")? "NULL" : "#{record.dep_id}"
  # account_type = (record.pay_id=="")? "NULL" : record.pay_id

  d = Material.new
  d.mat_id = record.mat_no 
  d.name = record.name
  d.description = record.desc
  d.accounting_type = record.mat_id

  case record.mat_no[0]
  when 'T','N','X','S','R'                #TNXSR為原料大類
    d.sno = record.mat_no[-2..-1]         #廠商簡碼
    mv = MasterialVendor.find_by_sno(sno)
    d.material_vendor_id = mv.id

    d.vendor_lot_no = record.mat_no[-8..-4]  #批號
    d.condition_id = record.mat_no[-10..-9]  #光澤+等級
  else

  end

  d.debit_code = record.acc_no
  d.credit_code = record.acc_no1
  d.is_shared_id = record.id
  d.is_quantity_control = record.qtyctrl
  d.measure_unit = record.um
  d.safe_quantity = record.sqty
  d.stocktake_quantity = record.pqty
  d.last_quantity = record.lqty
  d.total_quantity = record.bqty
  d.stocktake_quantity = record.pqty
  d.save
  
end

