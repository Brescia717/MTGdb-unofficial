class GamesController < ApplicationController
  def index
  end

  def show
    @deck            = Deck.find(params[:id])
    @library         = @deck.deck_data
    @hand            = Game.new(@library, []).mulligan.hand unless params[:mulligan]
    if session[:hand]
      session.delete(:hand) unless params[:mulligan]
    end
    if params[:mulligan]
      if @hand.nil? && session[:hand].nil?
        session[:hand] = Game.new(@library, []).mulligan.hand
      end
      @game = Game.new(@library, session[:hand])
      session.delete(:hand)
      @hand          = @game.mulligan.hand
      session[:hand] = @hand
      if @hand.size == 1
        session.delete(:hand)
        session[:hand] = []
      end
      @hand
    end
  end
end
