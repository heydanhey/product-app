class CartedProductsController < ApplicationController

  def new
  end

  def create
    @carted_product = CartedProduct.create({user_id: current_user.id, 
                                            product_id: params[:product_id],
                                            quantity: params[:quantity],
                                            status: "carted"
                                            })
    flash[:success] = "#{@carted_product.product.name} added to cart."
    redirect_to "/cart/"
  end

  def index
    @carted_products = CartedProduct.where(user_id: current_user.id, status: "carted")
    if @carted_products.empty?
      flash[:success] = "Your Cart is empty."
      redirect_to '/'
    end

    #@cartred_products = CartedProduct.where('user_id LIKE ? AND status LIKE?', current_user.id, "carted")
  end

  def destroy
    @carted_product = CartedProduct.find(params[:id])
    @carted_product.update({status: "removed"})

    flash[:warning] = "Product Removed From Cart"
    redirect_to "/cart"
  end


end
