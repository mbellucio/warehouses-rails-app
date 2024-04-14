class SuppliersController < ApplicationController
    def index
      @suppliers = Supplier.all
    end

    def show
      @supplier = Supplier.find(params[:id])
    end

    def new
      @supplier = Supplier.new
    end

    def create
      @supplier = Supplier.new(supplier_params)
      if @supplier.save
        return redirect_to supplier_path(@supplier.id), notice: "Supplier successfully registered!"
      end
      flash.now[:notice] = "Could not register supplier"
      render "new"
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
end
