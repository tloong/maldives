class FixedassetPartsController < ApplicationController
  def edit
    @department = Department.find(params[:department_id])
    @parts = FixedassetPart.where("department_id=? and part_no=?",params[:department_id],params[:id])
    @part_no = params[:id]
    @count  = FixedassetPart.where("department_id=? and part_no=?",params[:department_id],params[:id]).count
  end

  def update
    @department = Department.find(params[:department_id])

    if @department.update(fixedasset_parts_params)
      redirect_to parts_departments_path
    else
      render :edit
    end
  end
  private

  def fixedasset_parts_params
    params.require(:department).permit(:id,:fixedasset_parts_attributes =>
       [:id,:weight, :refed_department_id,:department_id, :part_no] )
  end
end
