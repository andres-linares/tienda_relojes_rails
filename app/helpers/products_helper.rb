module ProductsHelper
  def format_price price
    number_to_currency(price, separator: ',', delimiter: '.')
  end

  def crop_text text
    text.truncate(61)
  end
end
