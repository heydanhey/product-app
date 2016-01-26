class ImagesController < ApplicationController
  def new
  end

  def create
    @image = Image.create({product_id: params[:product_id], image: params[:image]})

    flash[:success] = "Image created"
    redirect_to "/"
  end
end
