class MeetingsController < ApplicationController
  before_action :set_meeting, only: [:show, :edit, :update, :destroy]

  def index
    @meetings = Meeting.all
  end

  def show
  end
 
  def new
    @meeting = Meeting.new
  end

  def edit
     @meeting = Meeting.find(params[:id])
  end

  def create
    @meeting = Meeting.new(meeting_params)

    respond_to do |format|
      if @meeting.save
        format.html { redirect_to @meeting, notice: '新增會議完成' }
      else
        format.html { render :new }
      end
    end
  end

  def update
     @meeting = Meeting.find(params[:id])
    if @meeting.update_attributes(meeting_params)
      flash[:info] = "編輯完成"
      redirect_to meetings_path
    else
      flash[:info] = "編輯失敗"
      render :edit
    end
  end

  def destroy
    @meeting.destroy
    respond_to do |format|
      format.html { redirect_to meetings_url, notice: '該會議已被刪除' }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_meeting
      @meeting = Meeting.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def meeting_params
      params.require(:meeting).permit(:meetingname, :date)
    end
end
