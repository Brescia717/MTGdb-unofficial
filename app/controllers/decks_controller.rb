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
      flash[:success] = "New deck created!"
      redirect_to @deck
    else
      render 'new'
    end
  end

  def edit
    @deck = Deck.find(params[:id])
    @deck_cards = @deck.library.map { |multiverseid| Card.find_by(multiverseid: multiverseid) } if @deck.library
    @card_search_for_library = Card.ransack(params[:q])
    @cards_for_deck = @card_search_for_library.result.page(params[:page]).limit(4)
  end

  def update
    deck = Deck.find(params[:id])
    if edit_deck_params[:add]
      library = deck.library + [edit_deck_params[:add].to_i]
      deck.update(library: library)
      flash[:success] = "A copy of #{Card.find_by(multiverseid: edit_deck_params[:add]).name} has been added to your deck."
    elsif edit_deck_params[:delete]
      library = deck.library - [edit_deck_params[:delete].to_i]
      deck.update(library: library)
      flash[:notice] = "A copy of #{Card.find_by(multiverseid: edit_deck_params[:delete]).name} has been removed from your deck."
    else
      render 'edit'
    end
    redirect_to deck
  end

  def destroy
    @deck = Deck.find(params[:id])
    if @deck.destroy
      flash[:notice] = "Your deck has been deleted."
      redirect_to decks_path
    end
  end

  private

  def deck_params
    params.require(:deck).permit(:name, :mtg_format, :library)
  end

  def edit_deck_params
    params.permit(:add, :delete)
  end

  def card_params
    params.permit(:multiverseid, :set_code, :rarity, :cmc, :colors, :name, :types, :subtypes, :text, :artist)
  end
end
