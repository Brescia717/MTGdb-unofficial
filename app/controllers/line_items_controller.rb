class LineItemsController < ApplicationController
  before_action :authenticate_user!
  
  def create
    @card      = Card.find(params[:card_id])
    @line_item = LineItem.create!(:cart => current_cart, :card => @card, :quantity => 1, :unit_price => @card.price)
    flash[:notice] = "Added #{@card.name} to cart."
    redirect_to current_cart
  end

  def update
    @line_item = LineItem.find(params[:id])
    quantity   = params['line_item']['quantity'].to_i
    @line_item.update(quantity: quantity)
    redirect_to current_cart
  end

  def destroy
    @line_item = LineItem.find(params[:id])
    @line_item.destroy!
    redirect_to current_cart
  end
end
