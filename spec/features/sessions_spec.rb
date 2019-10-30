require 'rails_helper'

RSpec.feature 'Sessions', type: :feature do
  scenario 'user login' do
    create_user_and_login
    expect(page).to have_content 'Signed in successfully.'
  end

  scenario 'admin login' do
    create_admin_and_login
    expect(page).to have_content 'Signed in successfully.'
  end

  scenario 'require login for app access' do
    visit questions_path
    expect(page).to have_content 'Login to Officeman'
  end

  scenario 'require admin for administrate access' do
    create_admin_and_login
    find('.dropdown').click
    find('.dropdown-item', text: 'Dashboard').click
    expect(page).to have_content 'Dashboard'
  end

  scenario 'shows alert on incorrect login credentials' do
    visit new_user_session_path
    fill_in 'Email',	with: 'user@localhost'
    fill_in 'Password',	with: 'wrong_password'
    click_button 'Login'
    expect(page).to have_content 'Invalid Email or password.'
  end
end
