class GamesController < ApplicationController
  def index
  end

  def show
    @deck             = Deck.find(params[:id])
    @library          = @deck.deck_data
    session[:library] ||= @library
    @game             = Game.new(@library, []) unless params[:mulligan]
    @hand             = @game.mulligan.hand unless params[:mulligan]

    if session[:hand]
      session.delete(:hand) unless params[:mulligan]
    end
    mulligan if params[:mulligan]
    draw     if (params[:draw] && session[:hand])
  end

  def mulligan
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

  def draw
    @hand    = session[:hand] if session[:hand]
    @library = session[:library] if session[:library]
    session[:game] = Game.new(@library, @hand)
    session[:game] = session[:game].draw

    session[:hand] = session[:game].hand
    @hand          = session[:hand]
    session[:library] = session[:game].library
    @hand
  end

private
  def game_params
    params.permit(:mulligan, :draw)
  end
end
