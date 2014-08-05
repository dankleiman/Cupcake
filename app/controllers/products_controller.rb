class ProductsController < ApplicationController
  def index
    @products = Product.amazon_search
  end
end
