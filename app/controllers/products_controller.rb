class ProductsController < ApplicationController
  def index
    @products = Product.all
  end

  def new
    @product = Product.new
  end

  def create
    product = Product.new(product_params)
    product.title = product.get_title(product.asin)
    if product.save
      redirect_to root_url
    else
      #error messages
    end
  end

  private

  def product_params
    params.require(:product).permit(:asin)
  end
end
