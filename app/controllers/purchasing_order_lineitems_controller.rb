class PurchasingOrderLineitemsController < ApplicationController
  before_action :set_purchasing_order_lineitem, only: [:show, :edit, :update, :destroy]

  def index
    @purchasing_order_lineitems = PurchasingOrderLineitem.all
  end

  def show
  end

  def new
    @purchasing_order = PurchasingOrder.find(params["purchasing_order_id"])
    @purchasing_order_lineitem = @purchasing_order.purchasing_order_lineitems.new
  end

  def edit
    @purchasing_order = PurchasingOrder.find(params["purchasing_order_id"])
    @purchasing_order_lineitem = PurchasingOrderLineitem.find(params[:id])
  end

  def create
    @purchasing_order_lineitem = PurchasingOrderLineitem.new(purchasing_order_lineitem_params)

    respond_to do |format|
      if @purchasing_order_lineitem.save
        format.html { redirect_to purchasing_order_path(@purchasing_order_lineitem.purchasing_order), notice: '新增訂購單檔身完成' }
      else
        format.html { render :new }
      end
    end
  end

  def update
    respond_to do |format|
      if @purchasing_order_lineitem.update(purchasing_order_lineitem_params)
        format.html { redirect_to purchasing_order_path(@purchasing_order_lineitem.purchasing_order), notice: '修改訂購單檔身完成' }
      else
        format.html { render :edit }
      end
    end
  end

  def destroy
    @purchasing_order = Purchasing_order.find(params["purchasing_order_id"])
    @purchasing_order_lineitem = PurchasingOrderLineitem.find(params[:id])
    @purchasing_order_lineitem.destroy
    respond_to do |format|
      format.html { redirect_to purchasing_order_path(@purchasing_order_lineitem.purchasing_order), notice: '刪除訂購單檔身完成' }
    end
  end

  private
    def set_purchasing_order_lineitem
      @purchasing_order_lineitem = PurchasingOrderLineitem.find(params[:id])
    end

    def purchasing_order_lineitem_params
      params.require(:purchasing_order_lineitem).permit(:purchasing_order_id, :sequence_no, :material_id, :quantity, :purchased_unit_price, :amount, :tax, :purchasing_requisition_no, :purchasing_requsition_seq_no, :purchasing_purpose, :purchasing_requisition_date, :goods_need_date, :shipping_location, :acceptance_certification_no, :close_case, :acc_type, :cost_department)
    end
end
