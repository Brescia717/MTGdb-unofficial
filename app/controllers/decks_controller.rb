class DecksController < ApplicationController
  before_action :authenticate_user!, except: :index

  def index
    @decks = Deck.all
  end

  def show
    @deck = Deck.find(params[:id])
    @user = current_user
  end

  def new
    @deck = Deck.new
  end

  def create
    @deck = Deck.new(deck_params)
    @deck.user = current_user
    if @deck.save
      # flash[:success] = "New deck created!"
      redirect_to @deck
    else
      render 'new'
    end
  end

  def edit
    @deck = Deck.find(params[:id])
    @deck_cards = @deck.library.map { |multiverseid| Card.find_by(multiverseid: multiverseid) }  if @deck.library
  end

  def update
    @deck = Deck.find(params[:id])
  end

  def destroy
    @deck = Deck.find(params[:id])
    if @deck.destroy
      # flash[:notice] = "Your deck has been deleted."
      redirect_to decks_path
    end
  end

  private

  def deck_params
    params.require(:deck).permit(:name, :mtg_format, :library => [])
  end
end
