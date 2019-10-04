require 'rails_helper'

RSpec.feature "Sessions", type: :feature do

  scenario "user login" do
    create_user_and_login
    expect(page).to have_content "Signed in successfully."
  end

  scenario "admin login" do
    create_admin_and_login
    expect(page).to have_content "Signed in successfully."
  end

  scenario "require login for app access" do
    visit questions_path
    expect(page).to have_content "Login to Officeman"
  end

  scenario "require admin for administrate access" do
    visit new_user_session_path
    create_admin_and_login
    find('.dropdown').click
    find('.dropdown-item', :text => 'Dashboard').click
    expect(page).to have_content "Back to Home"
  end
end
