class PurchasingOrdersController < ApplicationController
  before_action :set_purchasing_order, only: [:show, :edit, :update, :destroy]

  def index
    @purchasing_orders = PurchasingOrder.all
  end

  def show
  end

  def new
    @purchasing_order = PurchasingOrder.new
  end

  def edit
  end

  def create
    @purchasing_order = PurchasingOrder.new(purchasing_order_params)

    respond_to do |format|
      if @purchasing_order.save
        format.html { redirect_to @purchasing_order, notice: '新增訂購單完成' }
      else
        format.html { render :new }
      end
    end
  end

  def update
    respond_to do |format|
      if @purchasing_order.update(purchasing_order_params)
        format.html { redirect_to @purchasing_order, notice: '修改訂購單完成' }
      else
        format.html { render :edit }
      end
    end
  end

  def destroy
    @purchasing_order.destroy
    respond_to do |format|
      format.html { redirect_to purchasing_orders_url, notice: '刪除訂購單完成' }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_purchasing_order
      @purchasing_order = PurchasingOrder.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def purchasing_order_params
      params.require(:purchasing_order).permit(:purchasing_order_on, :purchase_date, :vendor_id, :department_id, :currency, :exchange_rate, :amount, :payment_location, :payment_type, :check_usance, :purchase_method, :purchase_category, :purchase_employee, :is_prepaid)
    end
end
