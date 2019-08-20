class PurchasesController < ApplicationController
  before_action :set_purchase, only: [:show, :edit, :update, :destroy]

  def index
    @purchases = Purchase.all
  end

  def new
    @purchase = Purchase.new
    @product = Product.find(params["product_id"])
  end
  
  def create
    @product = Product.find(params["product_id"])

    @purchase = Purchase.new(
      address: params["purchase"]["address"],
      telephone: params["purchase"]["telephone"],
      product_price: @product.price,
      product_discount: @product.discount,
      product_id: params["product_id"],
      user_id: 1
    )

    if @purchase.save      
      flash[:success] = "La compra fue realizada exitosamente"
    else
      flash[:danger] = "La compra no pudo ser realizada"
    end

    redirect_to root_path
  end


  private

    # Never trust parameters from the scary internet, only allow the white list through.
    def purchase_params
      params.require(:purchase).permit(:address, :telephone, :product_price, :product_discount, :product_id)
    end
end
