class AcceptanceCertificationsController < ApplicationController
	def index
    @q = AcceptanceCertification.search(params[:q])
    @acceptance_certifications = @q.result.includes(:acceptance_lineitems).page(params[:page])
    cookies[:last_acceptance_certifications_paginated] = params[:page]
  end

  def new    
    @acceptance_certification = AcceptanceCertification.new  
    @acceptance_certification.acceptance_lineitems.build
  end
  

  def show    
  	@acceptance_certification = current_user.acceptance_certifications.find(params[:id])
    # @acceptance_certification = AcceptanceCertification.find(params[:id])  
    @acceptance_lineitems = @acceptance_certification.acceptance_lineitems  
  end


  def edit
    @acceptance_certification = current_user.acceptance_certifications.find(params[:id])
    # @acceptance_certification = AcceptanceCertification.find(params[:id])   
    if @acceptance_certification.acceptance_lineitems.empty?
      @acceptance_lineitems = @acceptance_certification.acceptance_lineitems.build 
    end
  end

  def create   
  	@acceptance_certification = current_user.acceptance_certifications.new(acceptance_certification_params)
    # @acceptance_certification = AcceptanceCertification.new(acceptance_certification_params)

    if @acceptance_certification.save
      redirect_to acceptance_certifications_path, :notice => '新增驗收單成功'
    else
      render :new
    end
  end

  def update
 	@acceptance_certification = current_user.acceptance_certifications.find(params[:id])
    # @acceptance_certification = AcceptanceCertification.find(params[:id])

    if @acceptance_certification.update(acceptance_certification_params)
      redirect_to acceptance_certifications_path(@acceptance_certification, :notice => '修改驗收單成功', :page => cookies[:last_acceptance_certifications_paginated])
    else
      render :edit
    end
  end

  def destroy
  	@acceptance_certification = current_user.acceptance_certifications.find(params[:id])
    # @acceptance_certification = AcceptanceCertification.find(params[:id])
    
    @acceptance_certification.destroy
    redirect_to acceptance_certifications_path, :alert => '驗收單已刪除'
  end

  private
  
  # def group_params
  #     params.require(:group).permit(:title, :description)
  # end

  def acceptance_certification_params
    params.require(:acceptance_certification).permit( 
      :id, :accept_cert_no, :accept_cert_date, :currency, :exchange_rate,            
	  :amount, :tax, :discount_amount, :discount_tax, :invoice_no, :invoice_date,    
	  :note_for_payment, :voucher_no, :voucher_date, :acc_type, :vendor_id, :user_id, :department_id,
      :acceptance_lineitems_attributes =>[
      :id, :acceptance_certification_id, :purchasing_order_lineitem_id, :received_quantity,
	  :accepted_quantity, :ng_quantity, :unit_price, :total_amount, :tax, :discount_amount, 
      :discount_tax, :received_department_id, :acc_type, :cost_department_id, :special_flag,
      :material_id, :_destroy])
  end
end
