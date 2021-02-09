require 'rails_helper'

RSpec.feature "users can login.", type: :feature, js: true do

  # SETUP
  before :each do
    @user = User.create!(
      name: "Mona Lisa",
      email: "MonaLisa@daVinci.com",
      password: "hello",
      password_confirmation: "hello"
    )
  end

  scenario 'Taken to the home page once signed in' do
    visit login_path

    fill_in "email", with: "MonaLisa@daVinci.com"
    fill_in "password", with: "hello"
    click_button("Submit")

    # VERIFY
    save_screenshot "login.png"

    # DEBUG
    expect(page).to have_text 'Mona Lisa'
  end

end
