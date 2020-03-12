module Api
  module V1
    class ProductsController < ActionController::Base
      def index
        render json: Product.all, status: :ok
      end
    end
  end
end
