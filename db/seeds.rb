# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


  require 'json'

  file = File.read("AllSets-x.json")
  sets = JSON.parse(file)
  # cards = Array.new

  sets.each do |set_code, set_data|
    set_data['cards'].each do |c|
      Card.create!(
        name:       c['name'],       colors:     c['colors'],
        mana_cost:  c['manaCost'],   cmc:        c['cmc'],
        types:      c['types'],      subtypes:   c['subtypes'],
        rarity:     c['rarity'],     text:       c['text'],
        power:      c['power'],      toughness:  c['toughness'],
        legalities: c['legalities'], printings:  c['printings']
        )
    end
    puts "#{set_data['name']} added."
  end
=begin
  sets.first[1]['cards'].each do |c|
    cards << { name:              c['name'],
               manaCost:          c['manaCost'],
               colors:            c['colors'],
               types:             c['types'],
               subtypes:          c['subtypes'],
               rarity:            c['rarity'],
               text:              c['text'],
               power_toughness: [ c['power'], c['toughness'] ] }
  end

  cards.each do |c|
    def clean_field(card, key)
      if (card[key].is_a?(Array)) && (card[key].count == 1)
        card[key] = card[key].flatten.compact.first
      end
    end
    clean_field(c, :types)
    clean_field(c, :subtypes)
    clean_field(c, :colors)
    if (c[:power_toughness].is_a?(Array)) && (c[:types].include?("Creature") == false)
      c.delete(:power_toughness)
    end
  end
=end
