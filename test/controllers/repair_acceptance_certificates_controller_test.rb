require 'test_helper'

class RepairAcceptanceCertificatesControllerTest < ActionController::TestCase
  setup do
    @repair_acceptance_certificate = repair_acceptance_certificates(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:repair_acceptance_certificates)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create repair_acceptance_certificate" do
    assert_difference('RepairAcceptanceCertificate.count') do
      post :create, repair_acceptance_certificate: { accept_cert_date: @repair_acceptance_certificate.accept_cert_date, accept_cert_department: @repair_acceptance_certificate.accept_cert_department, amount: @repair_acceptance_certificate.amount, discount_amount: @repair_acceptance_certificate.discount_amount, discount_tax: @repair_acceptance_certificate.discount_tax, invoice_date: @repair_acceptance_certificate.invoice_date, invoice_no: @repair_acceptance_certificate.invoice_no, repair_accept_cert_no: @repair_acceptance_certificate.repair_accept_cert_no, repair_requisition_department: @repair_acceptance_certificate.repair_requisition_department, repair_requisition_no: @repair_acceptance_certificate.repair_requisition_no, request_date: @repair_acceptance_certificate.request_date, tax: @repair_acceptance_certificate.tax, vendor_id: @repair_acceptance_certificate.vendor_id }
    end

    assert_redirected_to repair_acceptance_certificate_path(assigns(:repair_acceptance_certificate))
  end

  test "should show repair_acceptance_certificate" do
    get :show, id: @repair_acceptance_certificate
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @repair_acceptance_certificate
    assert_response :success
  end

  test "should update repair_acceptance_certificate" do
    patch :update, id: @repair_acceptance_certificate, repair_acceptance_certificate: { accept_cert_date: @repair_acceptance_certificate.accept_cert_date, accept_cert_department: @repair_acceptance_certificate.accept_cert_department, amount: @repair_acceptance_certificate.amount, discount_amount: @repair_acceptance_certificate.discount_amount, discount_tax: @repair_acceptance_certificate.discount_tax, invoice_date: @repair_acceptance_certificate.invoice_date, invoice_no: @repair_acceptance_certificate.invoice_no, repair_accept_cert_no: @repair_acceptance_certificate.repair_accept_cert_no, repair_requisition_department: @repair_acceptance_certificate.repair_requisition_department, repair_requisition_no: @repair_acceptance_certificate.repair_requisition_no, request_date: @repair_acceptance_certificate.request_date, tax: @repair_acceptance_certificate.tax, vendor_id: @repair_acceptance_certificate.vendor_id }
    assert_redirected_to repair_acceptance_certificate_path(assigns(:repair_acceptance_certificate))
  end

  test "should destroy repair_acceptance_certificate" do
    assert_difference('RepairAcceptanceCertificate.count', -1) do
      delete :destroy, id: @repair_acceptance_certificate
    end

    assert_redirected_to repair_acceptance_certificates_path
  end
end
