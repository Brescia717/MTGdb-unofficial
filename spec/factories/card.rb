FactoryGirl.define do
  factory :card do
    name "Cryptic Command"
    colors "Blue"
    mana_cost "{1}{U}{U}{U}"
    cmc 4
    types "Instant"
    subtypes ""
    rarity "Rare"
    text "Best card imo"
    power ""
    toughness ""
    legalities "Modern"
    printings "Lorwyn"
    card_set "Lorwyn"
    set_code "LRW"
    # release_date
    multiverseid 141819
    card_number 1
    flavor "You just win."
    artist "Wayne England"
    image_url "https://api.mtgdb.info/content/card_images/141819.jpeg"
    hi_image_url "https://api.mtgdb.info/content/hi_res_card_images/141819.jpg"
    price 40.18
  end
end
