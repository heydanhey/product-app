class Product < ActiveRecord::Base
  belongs_to :supplier
  has_many :images

  has_many :categorized_products
  has_many :categories, through: :categorized_products

  has_many :carted_products
  has_many :orders, through: :carted_products

  validates :price, presence: true
  validates :price, numericality: true
  validates :price, numericality: { greater_than: 0 }

  validates :name, presence: true
  validates :name, uniqueness: true
  #validates :name, format: { with: /a-zA-Z/}

  validates :description, presence: true






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
