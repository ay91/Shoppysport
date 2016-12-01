require 'rails_helper'

RSpec.feature "Carts", type: :feature do

  scenario "add, update and delete items from cart" do
    category = create(:category)
    item = create(:item, :sequenced_title, :sequenced_price, :sequenced_description, :with_image, :category_id => category.id)

    visit category_item_path(category, item)
    expect(page).to have_css('input', 'Add To Cart')
    click_button("Add To Cart")
    expect(page).to have_selector('#flash-messages', text: "#{@item.title} have been added to cart")

  end
end
