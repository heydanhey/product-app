class OrdersController < ApplicationController

  def create
    @order = Order.new(quantity: params[:quantity],
                          user_id: current_user.id,
                          subtotal: params[:subtotal])

    @order.tax      = @order.calc_tax(0.09)

    @order.total    = @order.calc_total

    @order.save

    @carted_products = CartedProduct.where(user_id: current_user.id)
    @carted_products = @carted_products.where(status: "carted")

    @carted_products.each do |carted_product|
      carted_product.status = "purchased"
      carted_product.order_id = @order.id
      carted_product.save
    end

    #THIS IS TO DECREMENT INVENTORY
    @carted_products.each do |carted_product|
      carted_product.product.inventory -= carted_product.quantity
      if carted_product.product.inventory <= 0
        carted_product.product.in_stock = 0
      end
      carted_product.product.save
    end

    flash[:success] = "Order Created"
    redirect_to "/orders/#{@order.id}"
  end

  def index
    @orders = Order.all
  end

  def show
    @order = Order.find(params[:id])
    @carted_products = CartedProduct.where(order_id: @order.id)
  end
end
