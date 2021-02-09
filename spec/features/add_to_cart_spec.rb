require 'rails_helper'

RSpec.feature "Visitor navigates from home page to product detail page", type: :feature, js: true do

  # SETUP
  before :each do
    @category = Category.create! name: 'Apparel'

    10.times do |n|
      @category.products.create!(
        name:  Faker::Hipster.sentence(3),
        description: Faker::Hipster.paragraph(4),
        image: open_asset('apparel1.jpg'),
        quantity: 10,
        price: 64.99
      )
    end
  end

  scenario "The cart has 1 item in it" do
    # ACT
    visit root_path
    first('.product').click_on('Add')

    # VERIFY
    save_screenshot "saved_to_cart.png"

    # DEBUG
    expect(page).to have_text 'My Cart (1)'
  end

end 
