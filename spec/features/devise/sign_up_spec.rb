require 'rails_helper'

feature "User signs up" do
  let(:user) { build(:user) }

  background do
    visit root_path
    click_on("nav-signup-btn")
    expect(page).to have_content("Sign up")
  end

  scenario "successfully" do
    fill_in("Email", with: user.email)
    fill_in("Password", with: user.password)
    fill_in("Password confirmation", with: user.password_confirmation)

    click_button("reg-signup-btn")
    expect(page).to have_content("Welcome! You have signed up successfully.")
  end

  scenario "unsuccessfully; password too short" do
    fill_in("Email", with: "example@email.com")
    fill_in("Password", with: "1234567")
    fill_in("Password confirmation", with: "1234567")

    click_button("reg-signup-btn")
    expect(page).to have_content("error prohibited this user from being saved:")
  end
end
