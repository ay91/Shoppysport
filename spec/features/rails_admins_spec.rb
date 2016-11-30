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

  scenario "should allow admin access to admin panel" do
    admin = create(:user, :admin)
    visit root_path
    click_link('Login')
    fill_in 'Email', with: admin.email
    fill_in 'Password', with: admin.password
    click_button('Log in')
    expect(page).to have_link('Admin Panel')
    click_link('Admin Panel')
    expect(current_path).to eq '/admin'
  end
end
