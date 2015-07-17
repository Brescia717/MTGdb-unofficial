class LineItemsController < ApplicationController
  def create
    @card = Card.find(params[:card_id])
    @line_item = LineItem.create!(:cart => current_cart, :card => @card, :quantity => 1, :unit_price => @card.price)
    flash[:notice] = "Added #{@card.name} to cart."
    redirect_to current_cart_url
  end
end
