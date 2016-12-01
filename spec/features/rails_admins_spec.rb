require 'rails_helper'

RSpec.feature "RailsAdmins", type: :feature do

  scenario "should deny unlogged in user access to admin panel" do
    visit root_path
    expect(page).to_not have_button('Admin Panel')
  end

  scenario "should deny user access to admin panel" do
    user = create(:user)
    login_as(user, scope: :user)
    visit root_path
    expect(page).to_not have_button('Admin Panel')
  end

  scenario "should allow admin access to admin panel and add item" do
    admin = create(:user, :admin)
    item = create(:item, :sequenced_title, :sequenced_price, :sequenced_description, :with_image)
    category = create(:category, :sequenced_name)
    visit root_path
    click_link('Login')
    fill_in 'Email', with: admin.email
    fill_in 'Password', with: admin.password
    click_button('Log in')
    expect(page).to have_link('Admin Panel')
    click_link('Admin Panel')
    expect(current_path).to eq '/admin'

    # add item in rails admin
    click_link('Items', :href => ('/admin/item'))
    click_link('Add new')
    fill_in 'Title', with: item.title
    fill_in 'Description', with: item.description
    fill_in 'Price', with: item.price
    attach_file('Image', './spec/fixtures/racket-2.jpg')
    select category.name, from: 'Category'
    click_button('Save')

    # verify that item is on index page
    visit category_items_path(category)
    expect(page).to have_selector('div.item-child', count: 1)
  end
end
