class ProductsController < ApplicationController
  def show_all
    @products = Product.all
  end

  def home
    @products = Product.all
  end

  def show_one
    @products = Product.find()
  end
end
