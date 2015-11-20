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

  def get_price(card)
    set_name_param  = card.card_set if card.card_set
    card_name_param = card.name if card.name
    replacements    = [ [/,\s/, "+"], [/[\']/, ""] ]
    replacements.each { |r| card_name_param.gsub!(r[0], r[1]) }
    replacements.each { |r| set_name_param.gsub!(r[0], r[1]) }
    @url = "http://www.mtggoldfish.com/price/#{CGI.escape(set_name_param)}/#{CGI.escape(card_name_param)}#online"
    uri = URI.parse(@url)
    req = Net::HTTP.new(uri.host, uri.port)
    res = req.request_head(uri.path)
    if (res.code == "200")
      doc = Nokogiri::HTML(open(@url))
      paper_price = "$#{doc.at_css('div.price-box.paper div.price-box-price').text}"
    else
      paper_price = "Price not found."
      @url = '#'
    end
    paper_price
  end
end
