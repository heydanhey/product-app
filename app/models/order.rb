class Order < ActiveRecord::Base
  belongs_to :product
  belongs_to :user

  def friendly_time
    created_at.strftime("%m-%e-%y %H:%M")
  end

  def calc_subtotal(price)
    price * quantity
  end

  def calc_tax(tax_rate)
    subtotal * tax_rate
  end  

  def calc_total
    subtotal + tax
  end
end
