class CartsController < ApplicationController
  def show
    @cart = current_cart
    @cart_line_items = @cart.line_items.order('created_at ASC')
  end
end
