module Api
  module V1
    class ProductsController < ActionController::Base
      def index
        render json: Product.all, status: :ok
      end

      def show
        render json: Product.find(params[:id]), status: :ok
      end
    end
  end
end
