require 'test_helper'

class RepairAcceptanceCertificateLinesControllerTest < ActionController::TestCase
  setup do
    @repair_acceptance_certificate_line = repair_acceptance_certificate_lines(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:repair_acceptance_certificate_lines)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create repair_acceptance_certificate_line" do
    assert_difference('RepairAcceptanceCertificateLine.count') do
      post :create, repair_acceptance_certificate_line: { acc_type: @repair_acceptance_certificate_line.acc_type, cost_department: @repair_acceptance_certificate_line.cost_department, discount_amount: @repair_acceptance_certificate_line.discount_amount, discount_tax: @repair_acceptance_certificate_line.discount_tax, machine_category: @repair_acceptance_certificate_line.machine_category, machine_id: @repair_acceptance_certificate_line.machine_id, material_id: @repair_acceptance_certificate_line.material_id, received_quantity: @repair_acceptance_certificate_line.received_quantity, repair_accept_cert_date: @repair_acceptance_certificate_line.repair_accept_cert_date, repair_acceptance_certification_id: @repair_acceptance_certificate_line.repair_acceptance_certification_id, repair_reason: @repair_acceptance_certificate_line.repair_reason, repair_requisition_department: @repair_acceptance_certificate_line.repair_requisition_department, sequence_no: @repair_acceptance_certificate_line.sequence_no, speical_code: @repair_acceptance_certificate_line.speical_code, tax: @repair_acceptance_certificate_line.tax, total_amount: @repair_acceptance_certificate_line.total_amount, unit_price: @repair_acceptance_certificate_line.unit_price }
    end

    assert_redirected_to repair_acceptance_certificate_line_path(assigns(:repair_acceptance_certificate_line))
  end

  test "should show repair_acceptance_certificate_line" do
    get :show, id: @repair_acceptance_certificate_line
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @repair_acceptance_certificate_line
    assert_response :success
  end

  test "should update repair_acceptance_certificate_line" do
    patch :update, id: @repair_acceptance_certificate_line, repair_acceptance_certificate_line: { acc_type: @repair_acceptance_certificate_line.acc_type, cost_department: @repair_acceptance_certificate_line.cost_department, discount_amount: @repair_acceptance_certificate_line.discount_amount, discount_tax: @repair_acceptance_certificate_line.discount_tax, machine_category: @repair_acceptance_certificate_line.machine_category, machine_id: @repair_acceptance_certificate_line.machine_id, material_id: @repair_acceptance_certificate_line.material_id, received_quantity: @repair_acceptance_certificate_line.received_quantity, repair_accept_cert_date: @repair_acceptance_certificate_line.repair_accept_cert_date, repair_acceptance_certification_id: @repair_acceptance_certificate_line.repair_acceptance_certification_id, repair_reason: @repair_acceptance_certificate_line.repair_reason, repair_requisition_department: @repair_acceptance_certificate_line.repair_requisition_department, sequence_no: @repair_acceptance_certificate_line.sequence_no, speical_code: @repair_acceptance_certificate_line.speical_code, tax: @repair_acceptance_certificate_line.tax, total_amount: @repair_acceptance_certificate_line.total_amount, unit_price: @repair_acceptance_certificate_line.unit_price }
    assert_redirected_to repair_acceptance_certificate_line_path(assigns(:repair_acceptance_certificate_line))
  end

  test "should destroy repair_acceptance_certificate_line" do
    assert_difference('RepairAcceptanceCertificateLine.count', -1) do
      delete :destroy, id: @repair_acceptance_certificate_line
    end

    assert_redirected_to repair_acceptance_certificate_lines_path
  end
end
