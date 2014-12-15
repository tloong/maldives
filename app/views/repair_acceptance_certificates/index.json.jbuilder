json.array!(@repair_acceptance_certificates) do |repair_acceptance_certificate|
  json.extract! repair_acceptance_certificate, :id, :repair_accept_cert_no, :request_date, :repair_requisition_no, :repair_requisition_department, :accept_cert_date, :accept_cert_department, :vendor_id, :amount, :tax, :discount_amount, :discount_tax, :invoice_no, :invoice_date
  json.url repair_acceptance_certificate_url(repair_acceptance_certificate, format: :json)
end
