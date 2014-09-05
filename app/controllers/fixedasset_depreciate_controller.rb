class FixedassetDepreciateController < ApplicationController
  before_action :find_fixedasset

  def new
    @fixedasset_changed = FixedassetChanged.new
  end

  def create
    f_params = transfer_params 
    @fc = FixedassetChanged.new(f_params)
 
    if @fc.save
      @fixedasset.update_attributes :status => "depreciated_done"
      redirect_to fixedasset_path(@fixedasset)
    else
      render :new
    end
  end

private

  def find_fixedasset
    @fixedasset_id = params[:fixedasset_id]
    redirect_to fixedassets_url unless @fixedasset_id
    @fixedasset = Fixedasset.find(@fixedasset_id)
  end

  def transfer_params
    params.require(:fixedasset_changed).permit(:voucher_no, :fixedasset_id,:department_id, :old_department_id, :username, :changed_date,
      :change_type, :price, :reason, :note)
  end

end