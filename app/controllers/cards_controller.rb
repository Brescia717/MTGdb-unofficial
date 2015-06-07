class CardsController < ApplicationController
  def index
    @search = Card.search(params[:q])
    @cards  = @search.result.page(params[:page])
  end

  def show
    @card = Card.find_by(multiverseid: params[:multiverseid])
  end

  private

  def card_params
    params[:card].permit!
  end
end
