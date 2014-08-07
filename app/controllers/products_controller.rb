class ProductsController < ApplicationController
  def index
    @products = Product.all
  end

  def new
    @product = Product.new
  end

  def create
    product = Product.new(product_params)
    if product.save
      product.add_amazon_attributes!(product.asin)
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
