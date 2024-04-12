class WarehousesController < ApplicationController
  def show
    @warehouse = Warehouse.find(params[:id])
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

  def edit
    @warehouse = Warehouse.find(params[:id])
  end

  def update
    @warehouse = Warehouse.find(params[:id])
    if @warehouse.update(warehouse_params)
      return redirect_to warehouse_path(@warehouse.id), notice: "Warehouse sucessfully edited!"
    end
    flash.now[:notice] = "Warehouse not edited."
    render 'edit'
  end
end
