class ProductsController < ApplicationController

  def index
    @products = Product.all

    if params[:sort_up]
      @products = Product.order(:price)
    end

    if params[:sort_down]
      @products = Product.order(price: :desc)
    end

    if params[:discount]
      @products = Product.where("price < ?", params[:discount])
    end

    if params[:random]
      @product = Product.order("RAND()").first
      # redirect_to "/products/#{product.id}"
      render :show
    end
  end

  def show_all
    @products = Product.all
  end

  def home
    @products = Product.all
  end

  def show
    @product = Product.find_by(id: params[:id])
  end

  def new
  end

  def create
    @product = Product.create({name: params[:name],
                              price: params[:price],
                              supplier_id: params[:supplier][supplier_id],
                              description: params[:description],
                              inventory: params[:inventory],
                              in_stock: params[:in_stock]})

    flash[:success] = "Product Created"
    redirect_to "/"
  end

  def edit
    @product = Product.find(params[:id])
  end

  def update
    @product = Product.find(params[:id])
    @product.update({name: params[:name],
                              price: params[:price],
                              description: params[:description],
                              inventory: params[:inventory]})

    if params[:inventory].to_i <= 0
      @product.update({in_stock: false})
    else
      @product.update({in_stock: true})
    end

    flash[:success] = "Product Updated"
    redirect_to "/products/#{@product.id}"
  end

  def destroy
    @product = Product.find(params[:id])
    @product.destroy

    flash[:warning] = "Product Destroyed"
    redirect_to :action => :index, status: 303
  end

  def search
    @products = Product.where("name LIKE ? OR description LIKE ?", "%#{params[:search]}%", "%#{params[:search]}%")
    render :index
  end

end
