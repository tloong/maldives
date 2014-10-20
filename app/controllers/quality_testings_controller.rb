class QualityTestingsController < ApplicationController

  def index

  end

  def edit
    @quality_testing = QualityTesting.find(params[:id])
  end

  def new
    @quality_testing = QualityTesting.new
    @type = params[:type]
  end

  def create
    f_params = quality_testing_params
    f_params[:test_date] = Date.strptime(f_params[:test_date], '%Y-%m-%d')

    f_params[:spec] = f_params[:spec].upcase
    f_params[:lot_no] = f_params[:lot_no].upcase

    @quality_testing = QualityTesting.new(f_params)

    if @quality_testing.save
      flash[:notice] = "已新增一筆試驗記錄"
      redirect_to quality_testings_path
    else
      render :new
    end
  end

  def do_query_detail
    query_string = params[:query_string]
    query_string = query_string + " and " if query_string != ""

    query_string = query_string + " vendors.id = #{params[:vendor_id]}" if !params[:vendor_id].blank?
  
    @results = QualityTesting.select("vendors.alias as vendor_alias",
                                    "vendors.id as vendor_id", 
                                    "id",
                                    "spec", 
                                    "denier", 
                                    "strength",
                                    "elongation",
                                    "oil_content",
                                    "shrinkage",
                                    "cr_value",
                                    "entangling_value",
                                    "test_date",
                                    "note").joins(:vendor).where("#{query_string}").order(:test_date)
    
    @average = QualityTesting.select("spec",
                                    "avg(denier) as de", 
                                    "avg(strength) as st",
                                    "avg(elongation) as el",
                                    "avg(oil_content) as oi",
                                    "avg(shrinkage) as sh",
                                    "avg(cr_value) as cr",
                                    "avg(entangling_value) as en").joins(:vendor).where("#{query_string}").group(:spec)

  end

  def do_query
    @cond_hash = Hash.new

    if params[:vendor_name] != ""
      @cond_hash["vendors.name"] = params[:vendor_name]
    end

    if params[:spec] != ""
      @cond_hash["spec"] = params[:spec].upcase
    end

    if params[:lot_no] != ""
      @cond_hash["lot_no"] = params[:lot_no].upcase
    end

    query_string = view_context.hash_to_querystring(@cond_hash)
    
    if params[:specific_duration] == "specific"
      @cond_hash["start_date"] = params[:duration][0..9]
      @cond_hash["end_date"] = params[:duration][13..22]

      start_date = Date.strptime(@cond_hash["start_date"],"%Y/%m/%d")
      end_date = Date.strptime(@cond_hash["end_date"],"%Y/%m/%d")

      if query_string != ""
        query_string = query_string + " and "
      end
      query_string = query_string + " test_date >= '#{start_date}' and test_date <= '#{end_date}'"

    end

    @query_duration = params[:duration]
    @cond_hash["query_string"] = query_string
    @results = QualityTesting.select("vendors.alias as vendor_alias",
                                    "vendors.id as vendor_id", 
                                    "spec", 
                                    "avg(denier) as de", 
                                    "avg(strength) as st",
                                    "avg(elongation) as el",
                                    "avg(oil_content) as oi",
                                    "avg(shrinkage) as sh",
                                    "avg(cr_value) as cr",
                                    "avg(entangling_value) as en").joins(:vendor).where("#{query_string}").group(:vendor_id,:spec).order(:spec)
    @all = QualityTesting.select(   "spec", 
                                    "avg(denier) as de", 
                                    "avg(strength) as st",
                                    "avg(elongation) as el",
                                    "avg(oil_content) as oi",
                                    "avg(shrinkage) as sh",
                                    "avg(cr_value) as cr",
                                    "avg(entangling_value) as en").joins(:vendor).where("#{query_string}").group(:spec).order(:spec)
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
