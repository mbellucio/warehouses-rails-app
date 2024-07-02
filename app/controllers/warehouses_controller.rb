class WarehousesController < ApplicationController
  before_action :get_warehouse_by_id, only: [:edit, :update, :show, :destroy]

  def show
    @stocks = @warehouse.stock_products.group(:product_model).count
  end

  def new
    @warehouse = Warehouse.new
  end

  def create
    @warehouse = Warehouse.new(warehouse_params)
    if @warehouse.save()
      return redirect_to root_path, notice: "Warehouse sucessfully registered!"
    end
    flash.now[:notice] = "Warehouse not registered."
    render 'new'
  end

  def edit; end

  def update
    if @warehouse.update(warehouse_params)
      return redirect_to warehouse_path(@warehouse.id), notice: "Warehouse sucessfully edited!"
    end
    flash.now[:notice] = "Warehouse not edited."
    render 'edit'
  end

  def destroy
    @warehouse.destroy
    redirect_to root_path, notice: "Warehouse sucessfully removed!"
  end

  private
  def warehouse_params
    params.require(:warehouse).permit(
      :name,
      :code,
      :city,
      :area,
      :adress,
      :zip,
      :description
    )
  end

  def get_warehouse_by_id
    @warehouse = Warehouse.find(params[:id])
  end
end
