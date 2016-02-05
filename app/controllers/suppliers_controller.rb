class SuppliersController < ApplicationController

  before_action :authenticate_admin!, except: [:index]

  def index
    @suppliers = Supplier.all
  end

  def show
    @supplier = Supplier.find(params[:id])
  end

end
