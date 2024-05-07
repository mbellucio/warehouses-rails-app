class OrdersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_order_and_check_user, only: [:edit, :update, :show, :delivered, :canceled]

  def edit
    @warehouses = Warehouse.all
    @suppliers = Supplier.all
  end

  def update
    if @order.update(order_params)
      return redirect_to @order, notice: "Order was successfully updated"
    end
    @warehouses = Warehouse.all
    @suppliers = Supplier.all
    render "edit"
  end

  def index
    @orders = current_user.orders
  end

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

  def show; end

  def search
    @code = params[:query]
    @orders = Order.where("code LIKE?", "%#{@code}%")
  end

  def delivered
    @order.delivered!
    @order.order_items.each do |item|
      item.quantity.times do
        StockProduct.create(order: @order, product_model: item.product_model, warehouse: @order.warehouse)
      end
    end
    redirect_to @order
  end

  def canceled
    @order.canceled!
    redirect_to @order
  end

  private
  def set_order_and_check_user
    @order = Order.find(params[:id])
    if @order.user != current_user
      return redirect_to root_path, alert: "You don't have access to that order"
    end
  end

  def order_params
    params.require(:order).permit(
      :warehouse_id,
      :supplier_id,
      :arrival_date
    )
  end
end
