class Deck < ActiveRecord::Base
  belongs_to :user
  has_many   :cards
  has_many   :comments, as: :commentable, dependent: :destroy

  validates :name,
    presence: true,
    null: false
  validates :mtg_format,
    presence: true,
    null: false

  serialize :library, JSON

  paginates_per 12

  def library
    self[:library] || Array.new
  end

  def user_tag
    self.user.email.gsub(/@+\w+.+\z/, '')
  end

  def deck_data
    deck_data = []
    i = 1
    self.library.sort.each do |card_multiverseid|
      card = Card.find_by_multiverseid(card_multiverseid)
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

  def self.deck_search(name)
    where('name ILIKE ?', "%#{name}%")
  end
end
