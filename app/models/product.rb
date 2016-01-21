class Product < ActiveRecord::Base

  def sale_message
    if price.to_f < 2.00
      "#{price} - Discount Item!"
    else
      "#{price} - On Sale!"
    end
  end

  def tax
    "$%.2f" % (price.to_f * 0.09)
  end

  def total
    "$#{price.to_f + (price.to_f * 0.09)}"
  end

  def price_display
    '$%.2f' % price
  end

  def in_stock?
    if inventory <= 0
      "Sorry we're all out."
    else
      "This product is in stock! Amount in inventory: #{inventory}"
    end
  end

end
