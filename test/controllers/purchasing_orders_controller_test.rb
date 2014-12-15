require 'test_helper'

class PurchasingOrdersControllerTest < ActionController::TestCase
  setup do
    @purchasing_order = purchasing_orders(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:purchasing_orders)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create purchasing_order" do
    assert_difference('PurchasingOrder.count') do
      post :create, purchasing_order: { amount: @purchasing_order.amount, check_usance: @purchasing_order.check_usance, currency: @purchasing_order.currency, department_id: @purchasing_order.department_id, exchange_rate: @purchasing_order.exchange_rate, is_prepaid: @purchasing_order.is_prepaid, payment_location: @purchasing_order.payment_location, payment_type: @purchasing_order.payment_type, purchase_category: @purchasing_order.purchase_category, purchase_date: @purchasing_order.purchase_date, purchase_employee: @purchasing_order.purchase_employee, purchase_method: @purchasing_order.purchase_method, purchasing_order_on: @purchasing_order.purchasing_order_on, vendor_id: @purchasing_order.vendor_id }
    end

    assert_redirected_to purchasing_order_path(assigns(:purchasing_order))
  end

  test "should show purchasing_order" do
    get :show, id: @purchasing_order
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @purchasing_order
    assert_response :success
  end

  test "should update purchasing_order" do
    patch :update, id: @purchasing_order, purchasing_order: { amount: @purchasing_order.amount, check_usance: @purchasing_order.check_usance, currency: @purchasing_order.currency, department_id: @purchasing_order.department_id, exchange_rate: @purchasing_order.exchange_rate, is_prepaid: @purchasing_order.is_prepaid, payment_location: @purchasing_order.payment_location, payment_type: @purchasing_order.payment_type, purchase_category: @purchasing_order.purchase_category, purchase_date: @purchasing_order.purchase_date, purchase_employee: @purchasing_order.purchase_employee, purchase_method: @purchasing_order.purchase_method, purchasing_order_on: @purchasing_order.purchasing_order_on, vendor_id: @purchasing_order.vendor_id }
    assert_redirected_to purchasing_order_path(assigns(:purchasing_order))
  end

  test "should destroy purchasing_order" do
    assert_difference('PurchasingOrder.count', -1) do
      delete :destroy, id: @purchasing_order
    end

    assert_redirected_to purchasing_orders_path
  end
end
