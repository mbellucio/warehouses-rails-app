class SuppliersController < ApplicationController
    before_action :get_supplier_by_id, only: [:show, :edit, :update]

    def index
      @suppliers = Supplier.all
    end

    def show; end

    def new
      @supplier = Supplier.new
    end

    def create
      @supplier = Supplier.new(supplier_params)
      if @supplier.save
        return redirect_to supplier_path(@supplier.id), notice: "Supplier successfully registered!"
      end
      flash.now[:notice] = "Could not register supplier."
      render "new"
    end

    def edit; end

    def update
      if @supplier.update(supplier_params)
        return redirect_to supplier_path(@supplier.id), notice: "Supplier edited successfully!"
      end
      flash.now[:notice] = "Could not edit supplier."
      render "edit"
    end

    private
    def supplier_params
      params.require(:supplier).permit(
        :corporate_name,
        :brand_name,
        :registration_number,
        :adress,
        :city,
        :state,
        :email
      )
    end

    def get_supplier_by_id
      @supplier = Supplier.find(params[:id])
    end
end
