class GamesController < ApplicationController
  def index
  end

  def show
    @deck      = Deck.find(params[:id])
    @library   = @deck.deck_data
    # binding.pry
    if params[:mulligan]
      if session[:hand].nil?
        session[:hand] ||= []
        @game = Game.new(@library, session[:hand])
        session.delete(:hand)
        session[:hand] = @game.mulligan.hand
        @hand = session[:hand]
        binding.pry
      else
        @game = Game.new(@library, session[:hand])
        session.delete(:hand)
        session[:hand] = @game.mulligan.hand
        @hand = session[:hand]
        if @hand.size < 1
          session.delete(:hand)
        end
        binding.pry
      end
    end
  end
end
