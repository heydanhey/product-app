class OrdersController < ApplicationController

  def create
    price = Product.find(params[:product_id]).price

    @order = Order.new(quantity: params[:quantity],
                          user_id: current_user.id,
                          product_id: params[:product_id])

    @order.subtotal = @order.calc_subtotal(price)

    @order.tax      = @order.calc_tax(0.09)

    @order.total    = @order.calc_total

    @order.save

    @product = Product.find(@order.product_id)
    @product.update({inventory: @product.inventory -= @order.quantity})

    if @product.inventory <= 0
      @product.update({in_stock: 0})
    end

    flash[:success] = "Order Created"
    redirect_to "/orders/#{@order.id}"
  end

  def show
    @order = Order.find(params[:id])
  end
end
