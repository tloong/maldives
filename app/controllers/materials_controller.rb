class MaterialsController < ApplicationController

	def index 
    	@materials = Material.page(params[:page])
    	cookies[:last_deparments_page] = params[:page]
 	end

	def new
		@material = Material.new
	end

	def new1
		@material = Material.new
	end

	def create
		if Material.create(material_params)
			redirect_to :action => :index
		else
			render :action => :new
		end
	end

	def edit
		@material = Material.find(params[:id])
	end

	def update
		@material = Material.find(params[:id])

    	if @material.update(material_params)
     		# flash[:info] = "material_cat_lv2 #{@material_cat_lv2.alias} has been updated"
    		redirect_to :action => :index, :page => cookies[:last_deparments_page]
    	else
      		render :edit
    	end
    end

    def show
    	@material = Material.find(params[:id])
    end

	def destroy
		@material = Material.find(params[:id])
		@material.destroy
		redirect_to :action => :index
	end

	protected
	def find_material
		@material = Material.find(params[:id])
	end

	private
	def material_params
		params.require(:material).permit(:mat_id, :vendor_lot_no, :material_cat_lv1_id,
			:material_cat_lv2_id, :name, :condition_id, :sno, :description, :note, :accounting_type,
			:debit_code, :credit_code, :is_shared_id, :is_quantity_control, :is_sample,
			:measure_unit)
	end

end
