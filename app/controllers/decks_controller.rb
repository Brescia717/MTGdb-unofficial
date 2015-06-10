class DecksController < ApplicationController
  before_action :authenticate_user! only: {:create, :edit, :destroy}

  def index
    @decks = Deck.all
  end

  def show
    @deck = Deck.find(params[:id])
    @user = current_user
  end

  def create
    @deck            = current_user.decks.new
    @deck.name       = deck_params[:name]
    @deck.cards      = []
    @deck.mtg_format = deck_params[:mtg_format]
    @deck.save!
    flash[:success]  = "Your new deck with name #{deck_params[:name]} has been created!"
    redirect_to @deck
  end

  def edit
    @deck = Deck.find(params[:id])
    @deck_cards = @deck.cards.map { |multiverseid| Card.find_by(multiverseid: multiverseid) }  if @deck.cards
  end

  private

  def deck_params
    params.require(:deck).permit(:name, :cards, :mtg_format)
  end
end
