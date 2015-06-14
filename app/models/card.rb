class Card < ActiveRecord::Base
  validates_uniqueness_of :name

  belongs_to :decks
  belongs_to :users

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

  def self.card_search(name)
    where("cards.name ILIKE ?", "%#{name}%")
  end
end
