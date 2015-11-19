require 'rails_helper'

feature "User uses Card Search", js: true do
  let(:card) { create(:card)}

  background do
    visit cards_path
    expect(page).to have_content("Search for cards you would like")
    fill_in("cards_autocomplete_name", with: card.name)
    click_on "card-search-submit"

    expect(page).to have_css("#cards-table td#card-name")
  end

  scenario "and finds card successfully" do
    expect(page.first('#cards-table td#card-name').text).to eq(card.name)
  end

  scenario "and does not find card" do
    expect(page.first('#cards-table td#card-name').text).not_to eq("Incendiary Command")
  end
end
