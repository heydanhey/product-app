class Order < ActiveRecord::Base
  belongs_to :product
  belongs_to :user

  def friendly_time
    created_at.strftime("%m-%e-%y %H:%M")
  end
end
