class Card < ActiveRecord::Base
  validates_uniqueness_of :name

  belongs_to :decks
  belongs_to :users
  has_many   :comments, as: :commentable

  serialize :colors, JSON
  serialize :legalities, JSON
  serialize :printings, JSON

  paginates_per 10

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

  def self.card_search(name)
    where("cards.name ILIKE ?", "%#{name}%")
  end

  def self.update_prices
    cards = self.all
    cards.each do |card|
      if (card.updated_at < 7.days.ago) || card.price.nil?
        card_name_param = card.name.mb_chars.normalize(:kd) if card.name
        card_name_replacements = [ [/[Æ]/, "Ae"], [/[^\x00-\x7F]/, ''], [/[,\s]/, "+"], [/[:\']/, ""] ]
        card_name_replacements.each { |r| card_name_param.gsub!(r[0], r[1]).to_s }

        set_name_param  = card.card_set.mb_chars.normalize(:kd).gsub(/[^\x00-\x7F]/,'').to_s if card.card_set
        set_name_replacements  = [ [/[,\s]/, "+"], [/[\']/, ""] ]
        set_name_replacements.each { |r| set_name_param.gsub!(r[0], r[1]) }

        url = "http://www.mtggoldfish.com/price/#{CGI.escape(set_name_param)}/#{CGI.escape(card_name_param)}#paper"
        begin
          uri = URI.parse(url)
        rescue
          next
        end
        req = Net::HTTP.new(uri.host, uri.port)
        res = req.request_head(uri.path)
        if (res.code == "200")
          doc = Nokogiri::HTML(open(url))
          avg_price    = doc.at_css('div.price-box.paper div.price-box-price')
          lowest_price = doc.at_css('table.price-card-statistics-table.price-card-statistics-table2 tr[4] td.text-right')
          paper_price  = !avg_price.nil? ? "#{avg_price.text}" : "#{lowest_price.text}"
          new_price    = paper_price.to_f * 0.94
          card.price   = sprintf('%.2f', new_price)
          card.save unless card.price.nil?
        else
          next
        end
      else
        next
      end
    end
    puts "Update completed at #{Time.now}"
  end
end
