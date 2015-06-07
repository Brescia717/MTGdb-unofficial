class CardsController < ApplicationController
  def index
    @search = Card.search(params[:q])
    @cards  = @search.result.page(params[:page])
  end

  def show
    @card = Card.find_by(multiverseid: params[:multiverseid])
    @card_price = get_price(@card)
  end

  private

  def card_params
    params[:card].permit!
  end

  def get_price(card)
    set_name_param  = card.card_set if card.card_set
    card_name_param = card.name if card.name
    replacements    = [ [/\s/, "+"], [/,\s/, ",_"] ]
    replacements.each {|r| card_name_param.gsub!(r[0], r[1]) }
    replacements.each {|r| set_name_param.gsub!(r[0], r[1])  }
    @url = "http://www.mtggoldfish.com/price/#{set_name_param}/#{card_name_param}#online"
    uri = URI.parse(@url)
    req = Net::HTTP.new(uri.host, uri.port)
    res = req.request_head(uri.path)
    if (res.code == "200")
      doc = Nokogiri::HTML(open(@url))
      median_price = doc.at_css('div.price-box.paper div.price-box-price').text
    else
      median_price = '#'
    end
    median_price
  end
end
