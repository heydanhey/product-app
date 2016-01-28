class Product < ActiveRecord::Base

  has_many :orders
  belongs_to :supplier
  has_many :images

  def sale_message
    if price.to_f < 2.00
      "#{price} - Discount Item!"
    else
      "#{price} - On Sale!"
    end
  end

  def tax
    price.to_f * 0.09
  end

  def total
    price.to_f + (price.to_f * 0.09)
  end

  def price_display
    '$%.2f' % price
  end

  def in_stock?
    if inventory <= 0
      false
    else
      true
    end
  end

end
