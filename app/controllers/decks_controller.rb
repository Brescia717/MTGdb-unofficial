class DecksController < ApplicationController
  before_action :authenticate_user!, except: :index

  def index
    @decks = Deck.order(:updated_at).page(params[:page])
    @deck_search_results = Deck.deck_search(params[:deck_search])
                            .order("name DESC")
                            .page(params[:page]) if params[:deck_search]
  end

  def show
    @deck      = Deck.find(params[:id])
    @deck_data = @deck.deck_data
    @card_data = fetch_card_data(@deck_data)
    @user      = current_user
    if params[:draw_hand]
      @hand = []
      @draw_hand = Game.new(@deck_data, @hand).mulligan.hand
    end
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
    @basic_lands  = [2774, 294, 2770, 293, 277, 2742, 2766, 290, 2749, 289]
    @lib_quantity = @deck.library.sort.each_with_object(Hash.new(0)) { |mult_id, counts| counts[mult_id] += 1 }
    if params[:card_search]
      @cards = Card.card_search(params[:card_search]).order("cards.name DESC")
    end
  end

  def update
    @deck = Deck.find(params[:id])
    if edit_deck_params[:add]
      card    = [edit_deck_params[:add].to_i]
      library = @deck.library + card
      @deck.update(library: library)
      flash[:success] = "A copy of #{Card.find_by(multiverseid: edit_deck_params[:add]).name} has been added to your deck."
    elsif edit_deck_params[:delete]
      card    = edit_deck_params[:delete].to_i
      library = @deck.library
      library.delete_at library.index(card) unless library.index(card).nil?
      @deck.update(library: library)
      flash[:notice] = "A copy of #{Card.find_by(multiverseid: edit_deck_params[:delete]).name} has been removed from your deck."
    elsif edit_deck_params[:remove_all]
      card    = edit_deck_params[:remove_all].to_i
      library = @deck.library
      library.delete(card) unless library.index(card).nil?
      @deck.update(library: library)
    elsif edit_deck_params[:add_playset]
      card = [edit_deck_params[:add_playset].to_i]
      library =  @deck.library + card * 4
      @deck.update(library: library)
    end
    @deck.update(deck_params)
    redirect_to edit_deck_path
  end

  def destroy
    @deck = Deck.find(params[:id])
    if @deck.destroy
      flash[:notice] = "Your deck has been deleted."
      redirect_to decks_path
    end
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
    params.permit(:name, :mtg_format, :library)
  end

  def edit_deck_params
    params.permit(:add, :delete, :remove_all, :add_playset)
  end
end
