class ProductsController < ApplicationController
  def show
    @product = Product.find(params[:id])
  end

  def index
    @categories = Category.all
    @products = Product.all
  
    if params[:search].present?
      @products = @products.where("name ILIKE ?", "%#{params[:search]}%")
    end
  
    if params[:category].present?
      @products = @products.where(category_id: params[:category])
    end
  
    respond_to do |format|
      format.html
      format.js
    end
  end
end
