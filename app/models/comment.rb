class Comment < ActiveRecord::Base
  belongs_to :commentable, polymorphic: true
  belongs_to :user

  validates_presence_of :content, null: false

  def owner?(user)
    (self.user_id == user.id) ? true : false
  end

  def user_tag
    self.user.email.gsub(/@+\w+.+\z/, '')
  end
end
