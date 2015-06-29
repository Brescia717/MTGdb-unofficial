class GamesController < ApplicationController
  def index
  end

  def show
    [:library, :hand].each { |x| session.delete(x) } unless params[:mulligan]

    @deck               = Deck.find(params[:id])
    session[:library] ||= @deck.deck_data.shuffle!
    @library            = session[:library]
    session[:hand]    ||= Game.new(@library, []).mulligan.hand unless params[:mulligan]
    @hand               = session[:hand]

    mulligan if params[:mulligan]
  end

  def mulligan
    @game             = Game.new(@library, session[:hand])
    @hand             = @game.mulligan.hand
    @library          = @game.library
    session[:hand]    = @hand
    session[:library] = @library
    if @hand.size == 1
      session[:hand] = []
    end
    @hand
  end

private
  def game_params
    params.permit(:mulligan)
  end
end
