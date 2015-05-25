class CardsController < ApplicationController
  def index
    # @search = Card.search(params[:q])
    @cards  = Card.all.page(1).per(10) #Search.result
  end
end
