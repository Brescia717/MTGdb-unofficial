class GamesController < ApplicationController
  def index
  end

  def show
    @deck      = Deck.find(params[:id])
    @deck_data = load_deck_data(@deck)
    # binding.pry
  end

  def load_deck_data(deck)
    deck_data = []
    i = 1
    deck.library.sort.each do |card_multiverseid|
      card = Card.find_by_multiverseid(card_multiverseid)
      # binding.pry
      if deck_data.empty?
        deck_data << {:card => card, :index => i}
      else
        if deck_data.last[:card].multiverseid == (card_multiverseid)
          i += 1
          deck_data << {:card => card, :index => i}
        else
          i = 1
          deck_data << {:card => card, :index => i}
        end
      end
    end
    deck_data
  end
end
