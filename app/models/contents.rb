class Contents
  def quantity(array_of_cards)
    @q = 0
    array_of_cards.each { |c, q| @q += q }
    @q
  end

  def fetch_card_data(deck_data)
    @card_data = []
    deck_data.each do |c|
      @card_data << {
        id:           c[:card][:id],
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
    @card_data.each do |card|
      if card[:types].include?("Land")
        @lands << { name: card[:name], multiverseid: card[:multiverseid], id: card[:id] }
      elsif card[:types].include?("Creature") || card[:types].include?("Summon")
        @creatures << { name: card[:name], multiverseid: card[:multiverseid], id: card[:id] }
      elsif card[:types].include?("Instant") || card[:types].include?("Interrupt")
        @instants << { name: card[:name], multiverseid: card[:multiverseid], id: card[:id] }
      elsif card[:types].include?("Sorcery")
        @sorceries << { name: card[:name], multiverseid: card[:multiverseid], id: card[:id] }
      elsif card[:types].include?("Artifact")
        @artifacts << { name: card[:name], multiverseid: card[:multiverseid], id: card[:id] }
      elsif card[:types].include?("Enchantment")
        @enchantments << { name: card[:name], multiverseid: card[:multiverseid], id: card[:id] }
      end
    end
    @lands        = @lands.each_with_object(Hash.new(0)) { |card,counts| counts[card] += 1 }
    @creatures    = @creatures.each_with_object(Hash.new(0)) { |card,counts| counts[card] += 1 }
    @instants     = @instants.each_with_object(Hash.new(0)) { |card,counts| counts[card] += 1 }
    @sorceries    = @sorceries.each_with_object(Hash.new(0)) { |card,counts| counts[card] += 1 }
    @artifacts    = @artifacts.each_with_object(Hash.new(0)) { |card,counts| counts[card] += 1 }
    @enchantments = @enchantments.each_with_object(Hash.new(0)) { |card,counts| counts[card] += 1 }
    contents = { lands: @lands, creatures: @creatures, instants: @instants,
       sorceries: @sorceries, artifacts: @artifacts,
       enchantments: @enchantments }

    contents
  end

end
