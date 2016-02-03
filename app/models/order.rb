class Order < ActiveRecord::Base
  belongs_to :user
  
  has_many :carted_products
  has_many :products, through: :carted_products

  def friendly_time
    created_at.strftime("%A, %d %b %Y %l:%M %p")
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
