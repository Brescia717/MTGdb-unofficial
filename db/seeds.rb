require 'json'
require 'fileutils'
require 'net/http'
require 'open-uri'

file = File.read("AllSets-x.json")
sets = JSON.parse(file)
# cards = []

sets.each do |set_key, set_data|
  set_data['cards'].each do |c|
    if c['multiverseid'] == nil
      next
    else
      Card.create(
        name:         c['name'],              colors:       c['colors'],
        mana_cost:    c['manaCost'],          cmc:          c['cmc'],
        types:        c['types'],             subtypes:     c['subtypes'],
        rarity:       c['rarity'],            text:         c['text'],
        power:        c['power'],             toughness:    c['toughness'],
        legalities:   c['legalities'],        printings:    c['printings'],
        multiverseid: c['multiverseid'],      flavor:       c['flavor'],
        artist:       c['artist'],            card_number:  c['number'],
        card_set:     set_data['name'],       set_code:     set_data['code'],
        release_date: set_data['releaseDate'],
        image_url:    "https://api.mtgdb.info/content/card_images/#{c["multiverseid"]}.jpeg",
        hi_image_url: "https://api.mtgdb.info/content/hi_res_card_images/#{c["multiverseid"]}.jpg"
        )
    end
  end
  puts "#{set_data['name']} added."
end

# Add folders for set images
=begin
sets.each do |set_code, set_data|
  path = "images/#{set_data['name']}"
  FileUtils::mkdir_p path
  puts "Folder #{set_data['name']} created!"
end
=end

# Add images to respective folders
=begin
sets.each do |set_code, set_data|
  set_name = set_data['name']
  puts "Adding #{set_name}..."
  set_data['cards'].each do |c|
    url = "http://api.mtgdb.info/content/card_images/#{c['multiverseid']}.jpeg"
    uri = URI.parse(url)
    req = Net::HTTP.new(uri.host, uri.port)
    res = req.request_head(uri.path)
    if (res.code == "200")
      File.open("images/#{set_name}/#{c['name']}.jpeg", "wb") do |f|
        f.write open(url).read
      end
    else
      next
    end
  end
  puts "Set #{set_name} added!"
end
=end
