class ProductsController < ApplicationController
    def index

    end

    def new

    end

    def create
      puts params
      @product = Product.new(product_params)
    end

    private
    def product_params
      params.require(:product).permit(:name, :description, :price, images: [])
    end
end
