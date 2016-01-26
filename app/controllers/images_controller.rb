class ImagesController < ApplicationController
  def new
    if params[:auto]
      @product = Product.find(params[:auto])
    end
  end

  def create
    @image = Image.create({product_id: params[:product_id], image: params[:image]})

    flash[:success] = "Image created"
    redirect_to "/"
  end
end
