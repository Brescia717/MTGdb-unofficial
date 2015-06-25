class GamesController < ApplicationController
  def index
  end

  def show
    @deck      = Deck.find(params[:id])
    @library   = @deck.deck_data
    @hand    ||= []
    @game      = Game.new(@library, @hand)
    @starting_hand = @game.mulligan.hand
  end
end
