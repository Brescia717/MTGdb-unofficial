require 'rails_helper'

feature "User logs in" do
  let(:user) { create(:user) }

  background do
    visit root_path
    click_on("nav-signin-btn")
    expect(page).to have_content("Log in")
  end

  scenario "successfully" do
    fill_in("Email", with: user.email)
    fill_in("Password", with: user.password)

    click_button("sess-signin-btn")
    expect(page).to have_content("Signed in successfully.")
  end
end
