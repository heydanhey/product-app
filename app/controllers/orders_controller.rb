class OrdersController < ApplicationController

  def create
    @carted_products = CartedProduct.where(user_id: current_user.id).where(status: "carted")

    subtotal = 0
    @carted_products.each do |carted_product|
      subtotal += carted_product.product.price * carted_product.quantity
    end

    @order = Order.new(user_id: current_user.id,
                          subtotal: subtotal)

    @order.tax      = @order.calc_tax(0.09)

    @order.total    = @order.calc_total

    @order.save


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
    @orders = Order.where(user_id: current_user.id)
  end

  def show
    @order = Order.find(params[:id])
  end
end
