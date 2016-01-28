class OrdersController < ApplicationController

  def create
    @order = Order.create(quantity: params[:quantity],
                          user_id: current_user.id,
                          product_id: params[:product_id],
                          subtotal: params[:subtotal],
                          tax: params[:tax],
                          total: params[:total])

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
