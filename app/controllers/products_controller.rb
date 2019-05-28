class ProductsController < ApplicationController
    def index

    end

    def show
      @product = product
    end

    def new
      @product = Product.new
    end

    def create
      @product = Product.new(product_params)

      if @product.save
        redirect_to @product
      else

      end
    end

    def destroy
      @product = product
      @product.destroy

      redirect_to products_path
    end

    private
    def product
      @product ||= Product.find(params[:id])
    end

    def product_params
      params.require(:product).permit(:name, :description, :price, images: [])
    end
end
