class MaterialCatLv2sController < ApplicationController

	def index
		@material_cat_lv2s = MaterialCatLv2.all
	end

	def new
		@material_cat_lv2 = MaterialCatLv2.new
	end

	def create
		if MaterialCatLv2.create(material_cat_lv2_params)
			redirect_to :action => :index
		else
			render :action => :new
		end
	end

	def edit
		@material_cat_lv2 = MaterialCatLv2.find(params[:id])
	end

	def update
		@material_cat_lv2 = MaterialCatLv2.find(params[:id])

    	if @material_cat_lv2.update(material_cat_lv2_params)
     		# flash[:info] = "material_cat_lv2 #{@material_cat_lv2.alias} has been updated"
    		redirect_to :action => :index, :page => cookies[:last_deparments_page]
    	else
      		render :edit
    	end
    end

    def destroy
    	@material_cat_lv2 = MaterialCatLv2.find(params[:id])
    	@material_cat_lv2.destroy
    	redirect_to :action => :index
    end

    protected
    def find_material_cat_lv2
    	@material_cat_lv2 = MaterialCatLv2.find(params[:id])
    end

	private 
	def material_cat_lv2_params
		params.require(:material_cat_lv2).permit(:cat_id, :cat_name)
	end


end
