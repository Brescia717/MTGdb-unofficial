class SearchSuggestionsController < ApplicationController
  def index
    @card_names = Card.order(:name).where("name ILIKE ?", "%#{params[:term]}%").limit(5)
    render json: @card_names.map(&:name)
  end
end
