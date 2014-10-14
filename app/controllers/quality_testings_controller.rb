class QualityTestingsController < ApplicationController

  def index

  end

  def new
    @quality_testing = QualityTesting.new
  end

  def create
    f_params = quality_testing_params
    f_params[:test_date] = Date.strptime(f_params[:test_date], '%Y-%m-%d')

    @quality_testing = QualityTesting.new(f_params)

    if @quality_testing.save
      flash[:notice] = "已新增一筆試驗記錄"
      redirect_to quality_testings_path
    else
      render :new
    end

  end

  private

  def quality_testing_params
    params.require(:quality_testing).permit(
      :vendor_id, 
      :test_date, 
      :spec, :lot_no, :denier, :strength, :elongation, :oil_content, 
      :shrinkage, :entangling_value, :cr_value, :note)
  end

end
