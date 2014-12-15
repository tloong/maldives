json.array!(@repair_acceptance_certificate_lines) do |repair_acceptance_certificate_line|
  json.extract! repair_acceptance_certificate_line, :id, :repair_acceptance_certificate_id, :sequence_no, :material_id, :received_quantity, :unit_price, :total_amount, :tax, :discount_amount, :discount_tax, :repair_reason, :machine_category, :machine_id, :repair_requisition_department, :cost_department, :repair_accept_cert_date, :acc_type, :speical_code
  json.url repair_acceptance_certificate_line_url(repair_acceptance_certificate_line, format: :json)
end
