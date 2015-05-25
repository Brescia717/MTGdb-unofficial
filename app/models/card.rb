class Card < ActiveRecord::Base
  serialize :colors, JSON
  serialize :legalities, JSON
  serialize :printings, JSON
end
