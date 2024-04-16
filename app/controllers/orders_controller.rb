class OrdersController < ApplicationController
  before_action :authenticate_user!, only: [:new]

  def new
    @order = Order.new
    @warehouses = Warehouse.all
    @suppliers = Supplier.all
  end

  def create
    @order = Order.new(order_params)
    @order.user_id = current_user.id
    if @order.save
      return redirect_to @order, notice: "Order was successfully issued!"
    end
    @warehouses = Warehouse.all
    @suppliers = Supplier.all
    flash.now[:notice] = "Order could not be issued"
    render "new"
  end

  def show
    @order = Order.find(params[:id])
  end

  private
  def order_params
    params.require(:order).permit(
      :warehouse_id,
      :supplier_id,
      :arrival_date
    )
  end
end
