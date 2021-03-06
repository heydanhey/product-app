class ProductsController < ApplicationController

  before_action :authenticate_admin!, only: [:new, :create, :edit, :update, :destroy]

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

    if params[:category]
      @products = Category.find_by(name: params[:category]).products
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
    @carted_product = CartedProduct.new unless @carted_product 
  end

  def new
    @product = Product.new

  end

  def create
    @product = Product.new({name: params[:name],
                              price: params[:price],
                              supplier_id: params[:supplier][:supplier_id],
                              description: params[:description],
                              inventory: 100,
                              in_stock: 1})
    if @product.save
      if params[:image]
        Image.create({product_id: @product.id, image: params[:image]})
      else
        Image.create({product_id: @product.id, image: "http://shmector.com/preview/nature/cartoon-planet-vector_250x250.png"})
      end
      flash[:success] = "Product Created"
      redirect_to "/"
    else
      render :new
    end
  end

  def edit
    @product = Product.find(params[:id])
  end

  def update
    @product = Product.find(params[:id])

    if @product.update({name: params[:name],
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

    else

      render :edit

    end
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
