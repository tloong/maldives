class VendorsController < ApplicationController

  def index
    #@vendors = Vendor.includes(:contacts, :addresses)
    #@vendors = Vendor.includes(:vendor_contacts, :vendor_addresses).page(params[:page])
    @q = Vendor.search(params[:q])
    @vendors = @q.result.includes(:vendor_contacts, :vendor_addresses).page(params[:page])
    cookies[:last_vendors_paginated] = params[:page]
  end
  
  def new 
    @vendor = Vendor.new
    @vendor.vendor_addresses.build
    @vendor.vendor_contacts.build

  end

  def show
    @vendor = Vendor.find(params[:id])
    @vendor_addresses = @vendor.vendor_addresses
    @vendor_contacts = @vendor.vendor_contacts   
  end


  def edit
    @vendor = Vendor.find(params[:id])
    if @vendor.vendor_addresses.empty? 
      @vendor_addresses = @vendor.vendor_addresses.build 
    end
    if @vendor.vendor_contacts.empty?
      @vendor_contacts = @vendor.vendor_contacts.build 
    end
  end

  def update
    @vendor = Vendor.find(params[:id])
    if @vendor.update(vendor_params)
      redirect_to vendors_path(@vendor , :page => cookies[:last_vendors_paginated])
    else
      render :edit
    end
  end

  def create
    @vendor = Vendor.new(vendor_params)

    if @vendor.save
      redirect_to vendors_path
    else
      render :new
    end
  end

private

  def vendor_params
    params.require(:vendor).permit( 
      :id, :name, :alias, :pic_name, :fax, :vat_id, :product_type, :main_business,
      :payment_location, :payment_type, :payment_time, :check_usance,
      :bank_id, :bank_account_id, :bank_account_name, :receipter_vat_id, :notification_method,
      :is_pay_for_wire_fee,
      :vendor_addresses_attributes => [:id, :building_and_street, :address_type, :zipcode, :country, :_destroy],
      :vendor_contacts_attributes =>[:id, :name, :email, :phone, :phone2, :phone3, :_destroy])
  end

end
