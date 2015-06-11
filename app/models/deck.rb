class Deck < ActiveRecord::Base
  belongs_to :user
  has_many   :cards

  serialize :library, JSON

  def user_tag
    self.user.email.gsub(/@+\w+.+\z/, '')
  end
end
