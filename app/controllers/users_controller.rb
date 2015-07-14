class UsersController < ApplicationController
  before_action :authenticate_user!

  def index
  end

  def show
    @user  = User.find(params[:id])
    @decks = Deck.where(user_id: params[:id])
  end
end
