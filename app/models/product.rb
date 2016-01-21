class Product < ActiveRecord::Base

  def sale_message
    if price.to_f < 2.00
      "#{price} - Discount Item!"
    else
      "#{price} - On Sale!"
    end
  end

  def tax
    "$#{price.to_f * 0.09}"
  end

  def total
    " $#{price.to_f + (price.to_f * 0.09)}"
  end

  def in_stock?
    if in_stock == false
      "Yes, it's currently in stock!"
    else
      "Sorry we're all out."
    end
  end

end
