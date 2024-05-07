class OrderItemsController < ApplicationController
  def new
    @order = Order.find(params[:order_id])
    @order_item = OrderItem.new
    @product_models = @order.supplier.product_models
  end

  def create
    @order_item = OrderItem.new(order_item_params)
    @order = Order.find(params[:order_id])
    @order_item.order_id = @order.id
    if @order_item.save
      return redirect_to @order, notice: "Item added successfully!"
    end
  end

  private
  def order_item_params
    params.require(:order_item).permit(
      :product_model_id,
      :quantity
    )
  end
end
