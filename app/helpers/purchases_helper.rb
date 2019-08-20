module PurchasesHelper
  def format_price price
    number_to_currency(price, separator: ',', delimiter: '.')
  end
end
