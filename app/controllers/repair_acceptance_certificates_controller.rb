class RepairAcceptanceCertificatesController < ApplicationController
  before_action :set_repair_acceptance_certificate, only: [:show, :edit, :update, :destroy]

   def index
    @repair_acceptance_certificates = RepairAcceptanceCertificate.all
  end

  def show
  end

  def new
    @repair_acceptance_certificate = RepairAcceptanceCertificate.new
  end

  def edit
  end

  def create
    @repair_acceptance_certificate = RepairAcceptanceCertificate.new(repair_acceptance_certificate_params)

    respond_to do |format|
      if @repair_acceptance_certificate.save
        format.html { redirect_to @repair_acceptance_certificate, notice: '新增請購驗收單完成。' }
      else
        format.html { render :new }
      end
    end
  end

  def update
    respond_to do |format|
      if @repair_acceptance_certificate.update(repair_acceptance_certificate_params)
        format.html { redirect_to @repair_acceptance_certificate, notice: '修改請購驗收單完成。' }
      else
        format.html { render :edit }
      end
    end
  end

  def destroy
    @repair_acceptance_certificate.destroy
    respond_to do |format|
      format.html { redirect_to repair_acceptance_certificates_url, notice: '請購驗收單已被刪除。' }
    end
  end

  private
    def set_repair_acceptance_certificate
      @repair_acceptance_certificate = RepairAcceptanceCertificate.find(params[:id])
    end

    def repair_acceptance_certificate_params
      params.require(:repair_acceptance_certificate).permit(:repair_accept_cert_no, :request_date, :repair_requisition_no, :repair_requisition_department, :accept_cert_date, :accept_cert_department, :vendor_id, :amount, :tax, :discount_amount, :discount_tax, :invoice_no, :invoice_date)
    end
end
