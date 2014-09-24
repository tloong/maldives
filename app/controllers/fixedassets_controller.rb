class FixedassetsController < ApplicationController
  include FixedassetsHelper
  require 'fileutils'

  def index
    #@fixedassets = Fixedasset.all.page(params[:page])
    @q = Fixedasset.search(params[:q])
    @fixedassets = @q.result.paginate(:page => params[:page])
    if (params[:page] == nil)
      params[:page] = "1"
    end
    cookies[:last_fixedassets_paginated] = params[:page]
    
  end

  def get_file_names( path )
    
    files_by_ctime = {}
    Dir.chdir(path)
    Dir.entries(Dir.pwd).each do |f|
      next if f =~ /^\./    # ignore dot-files and dot-directories                                    

      full_filename = File.join( Dir.pwd , f)

      if File.directory?( full_filename )
        get_file_names( full_filename )
      else
        stat = File::Stat.new( full_filename )
        files_by_ctime[stat.ctime] ||= []
        files_by_ctime[stat.ctime] << full_filename
      end
    end
    Dir.chdir('..')
    return files_by_ctime
  end

  def do_batch_redep
    date = params['redep_date']
    if date ==""
      year = DateTime.now.year
      month = DateTime.now.month
    else
      year = date[0..3]
      month = date[5..6]
    end
    query_date = Date.new(year.to_i,month.to_i,1)
    @already_redep_fixedassets = []
    @valid_fixedassets = []

    ff = Fixedasset.where("final_scrap_value >= 100000 and end_use_date = ?", query_date)

    ff.each do |f|
      redep = f.fixedasset_redepreciation
      if redep == nil
        @valid_fixedassets.push(f)
        f_redep = FixedassetRedepreciation.new
        f_redep.fixedasset_id = f.id
        f_redep.re_original_value = f.final_scrap_value
        f_redep.re_final_scrap_value = (f.final_scrap_value.to_f/4).round
        f_redep.re_depreciated_value_per_month = ((f_redep.re_original_value - f_redep.re_final_scrap_value).to_f / 36).round
        f_redep.re_depreciated_value_last_month = f_redep.re_original_value - f_redep.re_final_scrap_value - (f_redep.re_depreciated_value_per_month*(35))
        f_redep.re_start_use_date = query_date + 1.month
        f_redep.re_end_use_date = query_date + 36.month
        f_redep.save
      else
        @already_redep_fixedassets.push(f)
      end
    end
  end

  def do_print
    date = params['print_date']
    print_type = params['print_type']
    
    if date ==""
      year = DateTime.now.year
      month = DateTime.now.month
    else
      year = date[0..3]
      month = date[5..6]
    end
    
    case print_type
    when "1"
      based_on = params['print_base_on']
      
      case params['report_type']
      when "all"
      PrintServices.new(year.to_i,month.to_i,based_on).perform
      when "simple"
        PrintServices2.new(year.to_i,month.to_i,based_on).perform
      end
      #Delayed::Job.enqueue PrintServices.new(year.to_i,month.to_i,based_on)
    when "2"
      #is_mortgaged = params['is_mortgaged']
      if (params['is_mortgaged'] == nil)
        is_mortgaged = false
      elsif (params['is_mortgaged'] == "checked")
        is_mortgaged = true
      end
      
      #PrintServices2.new.do_print(year.to_i, month.to_i)
      Delayed::Job.enqueue PrintServices3.new(year.to_i,month.to_i, is_mortgaged)
    when "3"
      
      p4 = PrintServices4.new(year.to_i,month.to_i,params['print_base_on'])
      p4.perform
      
    end

    redirect_to reports_fixedassets_path
  end

  def reports

    Dir.chdir(Rails.root.to_s)
    report_path = Rails.root.to_s + "/public/fixedassets_pdf/"
    
    unless File.directory?(report_path)
      FileUtils.mkdir_p(report_path)
    end
    @files_map =  get_file_names(report_path)  #Dir.glob('public/fixedassets/*')
  

    @files =  Dir.glob(report_path+"/*")

  end


  def show 
    @fixedasset = Fixedasset.find(params[:id])
    @fixedasset_changeds = @fixedasset.fixedasset_changeds
    @fixedasset_redepreciation = @fixedasset.fixedasset_redepreciation
  end

  def new 
    @fixedasset = Fixedasset.new
  end

  def create

    f_params = fixedasset_params 
    f_params[:fixed_asset_id] = f_params[:fixed_asset_id].upcase
      
    f_keys = ["fixed_asset_id","service_life_year","service_life_month"]
    error_code = check_fixedasset_params(f_params, f_keys)

    if (error_code == Fixedasset::NO_ERROR)
      fixed_asset_id = f_params[:fixed_asset_id]

      f_params[:ab_type] = fixed_asset_id[0]
      f_params[:year] = fixed_asset_id[1..2].to_i
      f_params[:category_id] = fixed_asset_id[3].to_i
      f_params[:category_lv2] = fixed_asset_id[4]
      f_params[:serial_no] = fixed_asset_id[5..7].to_i
      f_params[:sequence_no] = fixed_asset_id[9..10].to_i
    
      year = f_params["get_date"][0..3].to_i
      month = f_params["get_date"][5..6].to_i
      day = f_params["get_date"][8..9].to_i
      if day > 15
        if (month == 12)
          month = 1
          year = year + 1
        else
          month = month + 1
        end
      end
      day = 1 
      start_use_date = Date.new(year,month,day)

      if f_params[:sequence_no] != 0
        # 檢查並修正 service_life
        service_life_year, service_life_month = get_correct_service_life(fixed_asset_id,start_use_date) 
        f_params[:service_life_year] = service_life_year
        f_params[:service_life_month] = service_life_month
      end

      service_life_year = f_params[:service_life_year].to_i
      service_life_month = f_params[:service_life_month].to_i

      if (service_life_month == 0 && service_life_year == 0)
        f_params[:depreciated_value_last_month] = 0
        f_params[:depreciated_value_per_month] = 0
        f_params[:final_scrap_value] = f_params[:original_cost];
      else
        original_cost = f_params[:original_cost].to_i
        total_depreciated_month = (service_life_year*12) + service_life_month
        scrap_value = ((original_cost * 12).to_f / (total_depreciated_month+12)).round
        total_depreciated_price = original_cost - scrap_value
        f_params[:final_scrap_value] = scrap_value;
        depreciated_value_per_month  = (total_depreciated_price.to_f / total_depreciated_month).round
        if (total_depreciated_month == 1)
          f_params[:depreciated_value_last_month] = depreciated_value_per_month
          f_params[:depreciated_value_per_month] = 0
        else
          f_params[:depreciated_value_last_month] = total_depreciated_price - (depreciated_value_per_month*(total_depreciated_month-1))
          f_params[:depreciated_value_per_month] = depreciated_value_per_month
        end
      end

      @fixedasset = Fixedasset.new(f_params)
      @fixedasset.status = :in_use
      @fixedasset.start_use_date = start_use_date
      @fixedasset.end_use_date = @fixedasset.start_use_date + (service_life_year*12 + service_life_month -1).month
      @fixedasset.username = current_user.username
    else
      @fixedasset = Fixedasset.new(f_params)
    end

    if @fixedasset.save
      if f_params[:sequence_no] != 0 && service_life_month == 0 && service_life_year == 0
        # check if need to create redepreciation
        create_redepreciations_according_to_base_asset(fixed_asset_id,@fixedasset.start_use_date) 
      end 
      flash[:notice] = "已成功新增固定資產: #{@fixedasset.fixed_asset_id}"
      redirect_to fixedassets_path(@fixedasset, :page => cookies[:last_fixedassets_paginated])
    else
      render :new
    end
  end

  def edit
    @fixedasset = Fixedasset.find(params[:id])
  end

  def update
    @fixedasset = Fixedasset.find(params[:id])
    
    if @fixedasset.update_attributes(fixedasset_params)
      flash[:notice] = "已成功修改固定資產: #{@fixedasset.fixed_asset_id}"
      redirect_to fixedassets_path(@fixedasset, :page => cookies[:last_fixedassets_paginated])
    else
      render :edit
    end
  end

  private

  def fixedasset_params
    params.require(:fixedasset).permit(:fixed_asset_id, 
      :voucher_no, :name, :spec, :quantity, :unit, :original_cost, :get_date, 
      :service_life_year, :service_life_month, :department_id, :vendor_id, :note,
      :is_mortgaged)
  end


end
