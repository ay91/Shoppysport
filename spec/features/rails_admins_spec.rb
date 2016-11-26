require 'rails_helper'

RSpec.feature "RailsAdmins", type: :feature do

  scenario "should deny unlogged in user access to admin panel" do
    visit 'http://localhost:3000/admin'
    expect(page).to have_current_path(root_path)
  end

  scenario "should deny user access to admin panel" do
    user = create(:user)
    login_as(user, scope: :user)
    visit 'http://localhost:3000/admin'
    expect(page).to have_current_path(root_path)
  end

  scenario "should allow admin access to admin panel" do
    admin = create(:user, :admin)
    login_as(admin, :scope => :user)
    visit 'http://localhost:3000/admin'
    expect(current_path).to eq '/admin'
  end
end
