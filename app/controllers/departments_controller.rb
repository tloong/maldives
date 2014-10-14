class DepartmentsController < ApplicationController
  def parts
    part_nos = FixedassetPart.select(:part_no).distinct
    @parts = Hash.new
    @departments = Hash.new
    part_nos.each do |pn|
      case pn.part_no
      when 1
        d = Department.find_by_dep_id("1261")
        @parts[pn.part_no] = "土地、建物分攤比例 - [#{d.dep_id} #{d.alias}]"
        @departments[pn.part_no] = d.id
      when 2 
        d = Department.find_by_dep_id("0000")
        @parts[pn.part_no] = "土地、建物分攤比例 - [#{d.dep_id} #{d.alias}]"
        @departments[pn.part_no] = d.id
      when 3
        d = Department.find_by_dep_id("0000")
        @parts[pn.part_no] = "電器設備分攤比例 - [#{d.dep_id} #{d.alias}]"
        @departments[pn.part_no] = d.id
      end
    end
  end

  def index 
    @departments = Department.page(params[:page])
    #@departments = Department.includes(:department_contacts, :department_addresses).page(params[:page])
    cookies[:last_deparments_page] = params[:page]

  end

  def new
    @department = Department.new
  end

  def create
    if Department.create(department_params)
      redirect_to :action => :index
    else
      render :action => :new
    end
  end

  def show
    @department = Department.find(params[:id])
  end

  def edit
    @department = Department.find(params[:id])
  end

  def update
    @department = Department.find(params[:id])

    if @department.update(department_params)
      flash[:info] = "department #{@department.alias} has been updated"
      redirect_to :action => :index, :page => cookies[:last_deparments_page]
    else
      render :edit
    end
  end

  def destroy
    @department = Department.find(params[:id])
    @department.destroy
    redirect_to :action => :index
  end

  protected
  def find_department
    @department = Department.find(params[:id])
  end

  private
  def department_params
    params.require(:department).permit(
      :id, :dep_id, :name, :alias, :docket_head, :account_type)
  end

end
