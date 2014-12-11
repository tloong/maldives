class MaterialCatLv1sController < ApplicationController

	def index
		@material_cat_lv1s = MaterialCatLv1.all
	end

	def new
		@material_cat_lv1 = MaterialCatLv1.new
	end

	def create
		if MaterialCatLv1.create(material_cat_lv1_params)
			redirect_to :action => :index
		else
			render :action => :new
		end
	end

	def edit
		@material_cat_lv1 = MaterialCatLv1.find(params[:id])
	end

	def update
		@material_cat_lv1 = MaterialCatLv1.find(params[:id])

    	if @material_cat_lv1.update(material_cat_lv1_params)
     		# flash[:info] = "material_cat_lv2 #{@material_cat_lv2.alias} has been updated"
    		redirect_to :action => :index, :page => cookies[:last_deparments_page]
    	else
      		render :edit
    	end
    end

    def destroy
    	@material_cat_lv1 = MaterialCatLv1.find(params[:id])
    	@material_cat_lv1.destroy
    	redirect_to :action => :index
    end

    protected
    def find_material_cat_lv1
    	@material_cat_lv1 = MaterialCatLv1.find(params[:id])
    end

	private 
	def material_cat_lv1_params
		params.require(:material_cat_lv1).permit(:cat_id, :cat_name)
	end

end
