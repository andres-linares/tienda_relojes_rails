module ProductsHelper
  def format_price price
    number_to_currency(price, separator: ',', delimiter: '.')
  end

  def crop_text text
    text.truncate(61)
  end

  def apply_discount price, discount
    discounted_price = price * (discount / 100.0)
    new_price = price - discounted_price
  end
end
