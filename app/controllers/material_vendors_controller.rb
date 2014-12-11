class MaterialVendorsController < ApplicationController

	def index 
    	@material_vendors = MaterialVendor.page(params[:page])
    	cookies[:last_material_vendors_page] = params[:page]
 	end

	def new
		@material_vendor = MaterialVendor.new
	end

	def create
		if MaterialVendor.create(material_vendor_params)
			redirect_to :action => :index
		else
			render :action => :new
		end
	end

	def edit
		@material_vendor = MaterialVendor.find(params[:id])
	end

	def update
		@material_vendor = MaterialVendor.find(params[:id])

    	if @material_vendor.update(material_vendor_params)
     		# flash[:info] = "material_cat_lv2 #{@material_cat_lv2.alias} has been updated"
    		redirect_to :action => :index, :page => cookies[:last_material_vendors_page]
    	else
      		render :edit
    	end
    end

    def show
    	@material_vendor = MaterialVendor.find(params[:id])
    end

	def destroy
		@material_vendor = MaterialVendor.find(params[:id])
		@material_vendor.destroy
		redirect_to :action => :index
	end

	protected
	def find_material_vendor
		@material_vendor = MaterialVendor.find(params[:id])
	end

	private
	def material_vendor_params
		params.require(:material_vendor).permit(:sno, :name, :sid)
	end

end
