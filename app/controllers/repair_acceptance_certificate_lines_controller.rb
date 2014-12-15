class RepairAcceptanceCertificateLinesController < ApplicationController
  before_action :set_repair_acceptance_certificate_line, only: [:show, :edit, :update, :destroy]

  def index
    @repair_acceptance_certificate_lines = RepairAcceptanceCertificateLine.all
  end

  def show
  end

  def new                                                                     
    @repair_acceptance_certificate = RepairAcceptanceCertificate.find(params["repair_acceptance_certificate_id"])
    @repair_acceptance_certificate_line = @repair_acceptance_certificate.repair_acceptance_certificate_lines.new
  end

  def edit
    @repair_acceptance_certificate = RepairAcceptanceCertificate.find(params["repair_acceptance_certificate_id"])
    @repair_acceptance_certificate_line = RepairAcceptanceCertificateLine.find(params[:id])
  end

  def create
    @repair_acceptance_certificate_line = RepairAcceptanceCertificateLine.new(repair_acceptance_certificate_line_params)

    respond_to do |format|
      if @repair_acceptance_certificate_line.save
        format.html { redirect_to @repair_acceptance_certificate_line, notice: '新增請修驗收單檔身完成。' }
      else
        format.html { render :new }
      end
    end
  end

  def update
    @repair_acceptance_certificate = RepairAcceptanceCertificate.find(params["repair_acceptance_certificate_id"])
    @repair_acceptance_certificate_line = RepairAcceptanceCertificateLine.find(params[:id])
    respond_to do |format|
      if @repair_acceptance_certificate_line.update(repair_acceptance_certificate_line_params)
        format.html { redirect_to @repair_acceptance_certificate_line, notice: '編輯請修驗收單檔身完成。' }
      else
        format.html { render :edit }
      end
    end
  end

  def destroy
    @repair_acceptance_certificate = RepairAcceptanceCertificate.find(params["repair_acceptance_certificate_id"])
    @repair_acceptance_certificate_line = RepairAcceptanceCertificateLine.find(params[:id])
    @repair_acceptance_certificate_line.destroy
    respond_to do |format|
      format.html { redirect_to repair_acceptance_certificate_lines_url, notice: '請修驗收單檔身已被刪除。' }
    end
  end

  private
    def set_repair_acceptance_certificate_line
      @repair_acceptance_certificate_line = RepairAcceptanceCertificateLine.find(params[:id])
    end
    
    def repair_acceptance_certificate_line_params
      params.require(:repair_acceptance_certificate_line).permit(:repair_acceptance_certificate_id, :sequence_no, :material_id, :received_quantity, :unit_price, :total_amount, :tax, :discount_amount, :discount_tax, :repair_reason, :machine_category, :machine_id, :repair_requisition_department, :cost_department, :repair_accept_cert_date, :acc_type, :speical_code)
    end
end
