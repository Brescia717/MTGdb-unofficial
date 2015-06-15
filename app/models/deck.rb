class Deck < ActiveRecord::Base
  belongs_to :user
  has_many   :cards
  # accepts_nested_attributes_for :cards,
  #   reject_if: lambda { |a| a[:library].blank? },
  #   allow_destroy: true

  validates :name,
    presence: true,
    null: false
  validates :mtg_format,
    presence: true,
    null: false

  def library
    self[:library] || Array.new
  end

  serialize :library, JSON

  def user_tag
    self.user.email.gsub(/@+\w+.+\z/, '')
  end
end
