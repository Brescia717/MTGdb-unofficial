require 'rails_helper'

feature "User uses Card Search", js: true do
  card = FactoryGirl.create(:card)

  background do
    visit cards_path
  end

  scenario "successfully" do
    expect(page).to have_content("Search for cards you would like")
    fill_in("cards_autocomplete_name", with: card.name)
    click_on "card-search-submit"

    expect(page).to have_css("#cards-table td")
  end
end
