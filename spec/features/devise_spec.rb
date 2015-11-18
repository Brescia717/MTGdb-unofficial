require 'rails_helper'

feature "User signs up" do
  let(:user) {create(:user)}

  background do
    visit root_path
  end

  scenario "successfully" do
    visit "/users/sign_up"
    expect(page).to have_content("Sign up")

    fill_in("Email", with: user.email)
    fill_in("Password", with: user.password)
    fill_in("Password confirmation", with: user.password_confirmation)

    click_button("Sign up")
    expect(page).to have_content("You have successfully signed up")
  end
end
