json.array!(@purchasing_orders) do |purchasing_order|
  json.extract! purchasing_order, :id, :purchasing_order_on, :purchase_date, :vendor_id, :department_id, :currency, :exchange_rate, :amount, :payment_location, :payment_type, :check_usance, :purchase_method, :purchase_category, :purchase_employee, :is_prepaid
  json.url purchasing_order_url(purchasing_order, format: :json)
end
