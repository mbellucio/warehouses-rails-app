class ProductModelsController < ApplicationController
    before_action :authenticate_user!, only: [:index]

    def index
      @product_models = ProductModel.all
    end

    def new
      @product_model = ProductModel.new
      @suppliers = Supplier.all
    end

    def create
      @product_model = ProductModel.new(product_model_params)
      if @product_model.save
        return redirect_to @product_model, notice: "Product model successfully registered!"
      end
      flash.now[:notice] = "Unable to register product model"
      @suppliers = Supplier.all #very important!!!
      render "new"
    end

    def show
      @product_model = ProductModel.find(params[:id])
    end

    private
    def product_model_params
      params.require(:product_model).permit(
        :name,
        :weight,
        :height,
        :width,
        :depth,
        :sku,
        :supplier_id
      )
    end
end
