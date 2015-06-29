class GamesController < ApplicationController
  def index
  end

  def show
    unless (params[:mulligan] || params[:draw])
      [:library, :game, :hand].each { |x| session.delete(x) }
    end

    @deck               = Deck.find(params[:id])
    @library            = @deck.deck_data
    session[:library] ||= @library.shuffle!
    @game               = Game.new(@library, []) unless params[:mulligan]
    session[:hand]    ||= @game.mulligan.hand unless (params[:mulligan] || params[:draw])
    @hand               = session[:hand]

    mulligan if params[:mulligan]
    draw     if params[:draw]
  end

  def mulligan
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
    @game = Game.new(session[:library], session[:hand])
    @game.draw
    session[:game]    = @game
    session[:hand]    = session[:game].hand
    session[:library] = session[:game].library
    @hand             = session[:hand]
    @hand
  end

private
  def game_params
    params.permit(:mulligan, :draw)
  end
end
