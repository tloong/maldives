require 'test_helper'

class PurchasingOrderLineitemsControllerTest < ActionController::TestCase
  setup do
    @purchasing_order_lineitem = purchasing_order_lineitems(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:purchasing_order_lineitems)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create purchasing_order_lineitem" do
    assert_difference('PurchasingOrderLineitem.count') do
      post :create, purchasing_order_lineitem: { acc_type: @purchasing_order_lineitem.acc_type, acceptance_certification_no: @purchasing_order_lineitem.acceptance_certification_no, amount: @purchasing_order_lineitem.amount, close_case: @purchasing_order_lineitem.close_case, cost_department: @purchasing_order_lineitem.cost_department, goods_need_date: @purchasing_order_lineitem.goods_need_date, material_id: @purchasing_order_lineitem.material_id, purchased_unit_price: @purchasing_order_lineitem.purchased_unit_price, purchasing_order_id: @purchasing_order_lineitem.purchasing_order_id, purchasing_purpose: @purchasing_order_lineitem.purchasing_purpose, purchasing_requisition_date: @purchasing_order_lineitem.purchasing_requisition_date, purchasing_requisition_no: @purchasing_order_lineitem.purchasing_requisition_no, purchasing_requsition_seq_no: @purchasing_order_lineitem.purchasing_requsition_seq_no, quantity: @purchasing_order_lineitem.quantity, sequence_no: @purchasing_order_lineitem.sequence_no, shipping_location: @purchasing_order_lineitem.shipping_location, tax: @purchasing_order_lineitem.tax }
    end

    assert_redirected_to purchasing_order_lineitem_path(assigns(:purchasing_order_lineitem))
  end

  test "should show purchasing_order_lineitem" do
    get :show, id: @purchasing_order_lineitem
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @purchasing_order_lineitem
    assert_response :success
  end

  test "should update purchasing_order_lineitem" do
    patch :update, id: @purchasing_order_lineitem, purchasing_order_lineitem: { acc_type: @purchasing_order_lineitem.acc_type, acceptance_certification_no: @purchasing_order_lineitem.acceptance_certification_no, amount: @purchasing_order_lineitem.amount, close_case: @purchasing_order_lineitem.close_case, cost_department: @purchasing_order_lineitem.cost_department, goods_need_date: @purchasing_order_lineitem.goods_need_date, material_id: @purchasing_order_lineitem.material_id, purchased_unit_price: @purchasing_order_lineitem.purchased_unit_price, purchasing_order_id: @purchasing_order_lineitem.purchasing_order_id, purchasing_purpose: @purchasing_order_lineitem.purchasing_purpose, purchasing_requisition_date: @purchasing_order_lineitem.purchasing_requisition_date, purchasing_requisition_no: @purchasing_order_lineitem.purchasing_requisition_no, purchasing_requsition_seq_no: @purchasing_order_lineitem.purchasing_requsition_seq_no, quantity: @purchasing_order_lineitem.quantity, sequence_no: @purchasing_order_lineitem.sequence_no, shipping_location: @purchasing_order_lineitem.shipping_location, tax: @purchasing_order_lineitem.tax }
    assert_redirected_to purchasing_order_lineitem_path(assigns(:purchasing_order_lineitem))
  end

  test "should destroy purchasing_order_lineitem" do
    assert_difference('PurchasingOrderLineitem.count', -1) do
      delete :destroy, id: @purchasing_order_lineitem
    end

    assert_redirected_to purchasing_order_lineitems_path
  end
end
