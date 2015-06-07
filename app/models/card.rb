class Card < ActiveRecord::Base
  validates_uniqueness_of :name

  belongs_to :decks

  serialize :colors, JSON
  serialize :legalities, JSON
  serialize :printings, JSON

  paginates_per 15

  def type
    "#{self.types.delete('[","]')}" if self.types
  end

  def subtype
    "#{self.subtypes.delete('[","]')}" if self.subtypes
  end
  def type_and_subtype
    self.subtype ? "#{self.type} - #{self.subtype}" : "#{self.type}"
  end

  def power_and_toughness
    "#{self.power}/#{self.toughness}" if (self.power && self.toughness)
  end

  def sets_printed
    "#{self.printings.to_s.delete('[""]')}" if self.printings
  end

  def fetch_image
    "http://gatherer.wizards.com/Handlers/Image.ashx?multiverseid=#{self.multiverseid}&type=card"
  end

  # def fetch_price
  #   set_name_param  = self.card_set if self.card_set
  #   card_name_param = self.name if self.name
  #   replacements    = [ [/\s/, "+"], [/,\s/, ",_"] ]
  #   replacements.each {|r| card_name_param.gsub!(r[0], r[1]) }
  #   replacements.each {|r| set_name_param.gsub!(r[0], r[1])  }
  #   url = "http://www.mtggoldfish.com/price/#{set_name_param}/#{card_name_param}#online"
  #   uri = URI.parse(url)
  #   req = Net::HTTP.new(uri.host, uri.port)
  #   res = req.request_head(uri.path)
  #   if (res.code == "200")
  #     doc = Nokogiri::HTML(open(url))
  #     paper_price = doc.at_css('div.price-box.paper div.price-box-price').text
  #   else
  #     paper_price = '#'
  #   end
  #   paper_price
  # end
end
