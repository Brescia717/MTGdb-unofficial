class LineItem < ActiveRecord::Base
  belongs_to :cart
  belongs_to :card

  def full_price
    unit_price * quantity
  end
end
