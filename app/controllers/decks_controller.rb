class DecksController < ApplicationController
  before_action :authenticate_user!, except: :index

  def index
    @decks = Deck.order(:updated_at).page(params[:page])
    @deck_search_results = Deck.deck_search(params[:deck_search])
                            .order("name DESC")
                            .page(params[:page]) if params[:deck_search]
    session[:decks_path] = true
    session.delete(:cards_path)
  end

  def show
    @deck       = Deck.find(params[:id])
    @deck_data  = @deck.deck_data
    @deck_data.each { |x| @total ||= 0; x[:card][:price] ? @total += x[:card][:price] : next }
    @deck_price = @total ? "$#{@total}" : "$0.00"
    # @card_data  = fetch_card_data(@deck_data)
    @user       = current_user
    if params[:draw_hand]
      @hand      = []
      @draw_hand = Game.new(@deck_data, @hand).mulligan.hand
    end

    @commentable = @deck
    @comments    = @commentable.comments
    @comment     = Comment.new
  end

  def new
    @deck = Deck.new
  end

  def create
    @deck      = Deck.new(deck_params)
    @deck.user = current_user
    if @deck.save
      flash[:success] = "New deck created!"
      redirect_to @deck
    else
      render 'new'
    end
  end

  def edit
    @deck         = Deck.find(params[:id])
    @deck_cards   = @deck.library.map { |multiverseid| Card.find_by(multiverseid: multiverseid) } if @deck.library
    @basic_lands  = [2774, 294, 2770, 293, 277, 2742, 2766, 290, 2749, 289] # Multiverse ids of basic and snow-covered lands
    @lib_quantity = @deck.library.sort.each_with_object(Hash.new(0)) { |mult_id, counts| counts[mult_id] += 1 }
    if params[:card_search]
      @cards = Card.card_search(params[:card_search]).order("cards.name DESC") unless params[:card_search].blank?
    end
    session[:cards_path] = true
    session.delete(:decks_path)
  end

  def update
    @deck = Deck.find(params[:id])
    add         if edit_deck_params[:add]
    delete      if edit_deck_params[:delete]
    remove_all  if edit_deck_params[:remove_all]
    add_playset if edit_deck_params[:add_playset]
    if @library
      @deck.update(library: @library)
      redirect_to edit_deck_path(@deck)
    else
      @deck.update(deck_params)
      redirect_to @deck
    end
  end

  def destroy
    @deck = Deck.find(params[:id])
    if @deck.destroy
      flash[:alert] = "Your deck has been deleted."
      redirect_to decks_path
    end
  end

  ###################################
  ##  Controller specific methods  ##
  ###################################

  def add
    card    = [edit_deck_params[:add].to_i]
    @library = @deck.library + card
  end

  def delete
    card    = edit_deck_params[:delete].to_i
    @library = @deck.library
    @library.delete_at @library.index(card) unless @library.index(card).nil?
  end

  def remove_all
    card    = edit_deck_params[:remove_all].to_i
    @library = @deck.library
    @library.delete(card) unless @library.index(card).nil?
  end

  def add_playset
    card = [edit_deck_params[:add_playset].to_i]
    @library =  @deck.library + card * 4
  end

  def fetch_card_data(deck_data)
    card_data = []
    deck_data.each do |c|
      card_data << {
        name:         c[:card][:name],
        multiverseid: c[:card][:multiverseid],
        types:        c[:card][:types],
        index:        c[:index]
      }
    end
    @lands        = []
    @creatures    = []
    @instants     = []
    @sorceries    = []
    @artifacts    = []
    @enchantments = []
    card_data.each do |card|
      if card[:types].include?("Land")
        @lands << card[:name]
      elsif card[:types].include?("Creature") || card[:types].include?("Summon")
        @creatures << card[:name]
      elsif card[:types].include?("Instant") || card[:types].include?("Interrupt")
        @instants << card[:name]
      elsif card[:types].include?("Sorcery")
        @sorceries << card[:name]
      elsif card[:types].include?("Artifact")
        @artifacts << card[:name]
      elsif card[:types].include?("Enchantment")
        @enchantments << card[:name]
      end
    end
    @lands        = @lands.each_with_object(Hash.new(0)) { |card,counts| counts[card] += 1 }
    @creatures    = @creatures.each_with_object(Hash.new(0)) { |card,counts| counts[card] += 1 }
    @instants     = @instants.each_with_object(Hash.new(0)) { |card,counts| counts[card] += 1 }
    @sorceries    = @sorceries.each_with_object(Hash.new(0)) { |card,counts| counts[card] += 1 }
    @artifacts    = @artifacts.each_with_object(Hash.new(0)) { |card,counts| counts[card] += 1 }
    @enchantments = @enchantments.each_with_object(Hash.new(0)) { |card,counts| counts[card] += 1 }

    card_data
  end

private

  def deck_params
    params.require(:deck).permit(:name, :mtg_format, :library, :description)
  end

  def edit_deck_params
    params.permit(:add, :delete, :remove_all, :add_playset, :card_search)
  end
end
