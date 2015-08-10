class WelcomeController < ApplicationController
  def index
    @set = "Lorwyn"
    @carousel = Card.where(card_set: "Lorwyn", rarity: "Rare").sample(7)
  end
end
