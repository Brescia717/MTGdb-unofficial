class GamesController < ApplicationController
  def index
  end

  def show
    @deck      = Deck.find(params[:id])
    @deck_data = @deck.deck_data
  end

end
