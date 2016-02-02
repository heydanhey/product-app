class CartedProductsController < ApplicationController

  def new
  end

  def create
    @carted_product = CartedProduct.create({user_id: current_user.id, 
                                            product_id: params[:product_id],
                                            quantity: params[:quantity],
                                            status: "carted"
                                            })
    redirect_to "/cart/"
  end

  def index
    @carted_products = CartedProduct.where(user_id: current_user.id)
    @carted_products = @carted_products.where(status: "carted")
    if @carted_products.empty?
      flash[:success] = "Your Cart is empty."
      redirect_to '/'
    end

    # @cartred_products = CartedProduct.where('user_id LIKE ? AND status LIKE?', current_user.id, "carted")

    @total_quantity = 0
    @subtotal = 0
    @carted_products.each do |carted_product|
      @total_quantity += carted_product.quantity
      @subtotal += carted_product.product.price
    end
  end

  def destroy
    @carted_product = CartedProduct.find(params[:id])
    @carted_product.update({status: "removed"})

    flash[:warning] = "Product Removed From Cart"
    redirect_to "/cart"
  end


end
