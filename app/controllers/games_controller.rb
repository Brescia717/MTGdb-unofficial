class GamesController < ApplicationController
  def index
  end

  def show
    @deck            = Deck.find(params[:id])
    @library         = @deck.deck_data
    session[:hand] ||= []
    @game            = Game.new(@library, session[:hand])
    if params[:mulligan]
      if session[:hand].empty?
        @game          = Game.new(@library, session[:hand])
        session.delete(:hand)
        session[:hand] = @game.mulligan.hand
        @hand          = session[:hand]
      else
        @game          = Game.new(@library, session[:hand])
        session.delete(:hand)
        session[:hand] = @game.mulligan.hand
        @hand          = session[:hand]
        if @hand.size == 1
          session.delete(:hand)
        end
      end
      @hand
    end
  end
end
