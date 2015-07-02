class SearchSuggestionsController < ApplicationController
  def index

    @card_names = Card.order(:name).where("name ILIKE ?", "%#{params[:term]}%").limit(5)
    @deck_names = Deck.order(:name).where("name ILIKE ?", "%#{params[:term]}%").limit(5)

    render json: @card_names.map(&:name) if session[:cards_path]
    render json: @deck_names.map(&:name) if session[:decks_path]
  end
end
