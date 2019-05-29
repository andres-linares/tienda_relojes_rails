class ProductsController < ApplicationController
    before_action :set_paper_trail_whodunnit
    
    def index

    end

    def show
      @product = product
    end

    def new
      @product = Product.new
    end

    def edit
      @product = product
    end

    def create
      @product = Product.new(product_params)

      if @product.validate(params[:product])
        @product.save
        redirect_to @product
      else
        flash[:danger] = 'Los detalles del producto no son validos.'
        render :edit
      end
    end

    def update
      @product = product

      if @product.update product_params
        redirect_to @product
      else
        flash[:danger] = "El producto no pudo ser actualizado."
        render :edit
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
      params.require(:product).permit(:name, :description, :price, :brand_id, images: [])
    end
end
