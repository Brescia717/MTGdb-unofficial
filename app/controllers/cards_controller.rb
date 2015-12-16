class CardsController < ApplicationController
  def index
    @search = Card.search(params[:q])
    @cards  = @search.result.page(params[:page]) if params[:q]
    session[:cards_path] = true
    session.delete(:decks_path)

    @card_colors = SearchFields.new.colors
    @card_types  = SearchFields.new.types
    @card_legal_formats = SearchFields.new.legal_formats
  end

  def show
    @card        = Card.find_by(multiverseid: (params[:multiverseid] || params[:id]))
    @card_price  = @card.price ? "$#{@card.price}" : "Card not available"
    @card_set    = @card.card_set.gsub(/[+]/, ' ')
    @card.name   = @card.name.gsub(/[+]/, ' ')

    @commentable = @card
    @comments    = @commentable.comments
    @comment     = Comment.new
  end


  private

  def card_params
    params[:card].permit!
  end

end
