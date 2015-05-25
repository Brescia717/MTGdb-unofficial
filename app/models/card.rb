class Card < ActiveRecord::Base
  serialize :colors, JSON
  serialize :legalities, JSON
  serialize :printings, JSON

  def type_and_subtype
    "#{self.types.delete('[""]')} - #{self.subtypes.delete('[""]')}" if (self.types && self.subtypes)
  end

  def power_and_toughness
    "#{self.power}/#{self.toughness}" if (self.power && self.toughness)
  end
end
