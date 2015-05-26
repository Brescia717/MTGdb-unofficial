class CardsController < ApplicationController
  def index
    @search = Card.search(params[:q])
    @cards  = @search.result.page params[:page]
  end
end
