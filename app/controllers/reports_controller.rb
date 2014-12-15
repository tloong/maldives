class ReportsController < ApplicationController
  before_action :set_report, only: [:show, :edit, :update, :destroy]

  def index
    @reports = Report.all
  end

  def show
  end

  def new
    @meeting = Meeting.find(params["meeting_id"])
    @report = @meeting.reports.new
  end

  def edit
    @meeting = Meeting.find(params["meeting_id"])
    @report = Report.find(params[:id])
  end

  def create
    @report = Report.new(report_params)

    respond_to do |format|
      if @report.save
        format.html { redirect_to meeting_path(@report.meeting), notice: '新增報告完成' }
      else
        format.html { render :new }
      end
    end
  end

  def update
    @meeting = Meeting.find(params["meeting_id"])
    @report = Report.find(params[:id])
    respond_to do |format|
      if @report.update(report_params)
        format.html { redirect_to meeting_path(@report.meeting), notice: '報告編輯完成' }
      else
        format.html { render :edit }
      end
    end      
  end

   def destroy
    @meeting = Meeting.find(params["purchasing_order_id"])
     @report = Report.find(params[:id])
     @report.destroy
     respond_to do |format|
     if 
      format.html { redirect_to meeting_path(@report.meeting), notice: '該報告已被刪除' }
     end
   end
  end
 


  

  private
    def set_report
      @report = Report.find(params[:id])
    end

    def report_params
      params.require(:report).permit(:meeting_id, :name, :module, :this_week_work, :need_help, :next_week_work, :share_tech)
    end
    
end
