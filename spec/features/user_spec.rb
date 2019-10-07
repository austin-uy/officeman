require 'rails_helper'

RSpec.feature "Users", type: :feature do
  
  scenario "adds an answer" do
    create :text
    create_user_and_login

    visit questions_path
    fill_in "answer_answer",	with: "some answer" 
    click_button "Submit"
    expect(page).to have_content "Answer submit successful."
  end

  scenario "edits an answer" do
    create :text
    create_user_and_login
    user_answer_question

    click_link "Answered"
    click_button ":"
    click_link "Edit"
    fill_in "answer_answer",	with: "edited answer" 
    click_button "Submit"
    expect(page).to have_content "Answer edited."
  end

  scenario "removes an answer", js: true do
    create :text
    create_user_and_login
    user_answer_question

    click_link "Answered"
    click_button ":"
    click_link "Remove"
    page.driver.browser.switch_to.alert.accept
    expect(page).to have_content "Answer deleted."
  end

  scenario "views assigned equipment" do
    user = create_user_and_login
    create(:equipment, user_id: user.id)

    visit equipment_index_path
    expect(page).to have_content "Thing"
  end

  scenario "edits own profile" do
    create_user_and_login

    find('.dropdown').click
    find('.dropdown-item', :text => 'Edit Profile').click

    fill_in "Name",	with: "New User" 
    click_button "Submit"
    expect(page).to have_content "User edited."
  end
  

  scenario "visits users list" do
    create_user_and_login
    
    visit users_path
    expect(page).to have_content "Access denied."
  end

  scenario "visits admin dashboard" do
    create_user_and_login
    
    visit admin_root_path
    expect(page).to have_content "Access denied."
  end
end
