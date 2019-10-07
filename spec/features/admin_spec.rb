require 'rails_helper'

RSpec.feature "Admins", type: :feature do
  
  scenario "views all show_in_list question" do
    question = create :text, show_in_list: true
    create_admin_and_login
 
    visit home_path
    expect(page).to have_content question.question
  end
  
  scenario "views all user" do
    user = create :user
    create_admin_and_login

    visit users_path
    expect(page).to have_content user.name
  end

  scenario "adds a user", js: true do
    create_admin_and_login

    visit users_path
    click_link "Add User"

    fill_in "Name",	with: "New User" 
    input = find(:id, "user_email")
    input.click.send_keys "new_user"
    input.click.send_keys "@"
    input.click.send_keys "localhost"
    select 'User', from: 'user_role'
    fill_in "Password",	with: "password"
    click_button 'Submit'
    expect(page).to have_content "User added."
  end

  scenario "show all answers by user" do
    user = create :user
    question = create :text
    answer = create :answer, question_id: question.id, user_id: user.id
    create_admin_and_login

    visit users_path
    click_button ":"
    click_link "Show Answers"
    expect(page).to have_content answer.answer
  end

  scenario "edits a user" do
    user = create :user
    create_admin_and_login

    visit users_path
    click_button ":"
    click_link "Edit"

    fill_in "user_name",	with: "New name"
    click_button "Submit" 
    expect(page).to have_content "User edited."
  end

  scenario "removes a user", js: true do
    user = create :user
    create_admin_and_login

    visit users_path
    click_button ":"
    click_link "Remove"
    page.driver.browser.switch_to.alert.accept
    expect(page).to have_content "User deleted."
  end
  
  scenario "views all questions" do
    question = create :text
    create_admin_and_login
    
    visit questions_path
    expect(page).to have_content question.question
  end

  scenario "adds a question (text)", js: true do
    create_admin_and_login

    visit questions_path
    click_button "Add Question"

    fill_in "Question",	with: "What?"
    check 'Show in list?'
    select 'text', from: 'Answer Type'
    click_button "Submit"
    expect(page).to have_content "Question added."
  end

  scenario "edits a question", js: true do
    question = create :text
    create_admin_and_login
    
    visit questions_path
    click_link "Edit"
    fill_in "Question",	with: "How?"
    click_button "Submit"
    expect(page).to have_content "Question edited."
  end
  
  scenario "removes a question", js: true do
    question = create :text
    create_admin_and_login
    
    visit questions_path
    click_link "Remove"
    page.driver.browser.switch_to.alert.accept
    expect(page).to have_content "Question deleted."
  end
  
  scenario "views all equipment" do
    user = create :user
    equipment = create :equipment, user_id: user.id
    create_admin_and_login
    
    visit equipment_index_path
    expect(page).to have_content equipment.name
  end

  scenario "adds an equipment", js: true do
    user = create :user
    create_admin_and_login

    visit equipment_index_path
    click_link "Add Equipment"
    fill_in "name",	with: "Some Equipment"
    select "Hardware", from: "Equipment type"
    select "Deployed", from: "Status"
    select user.name , from: "Assigned User"
    click_button "Submit"
    expect(page).to have_content "Equipment added."
  end

  scenario "edits an equipment", js: true do
    user = create :user
    create :equipment, user_id: user.id
    create_admin_and_login

    visit equipment_index_path
    click_button ":"
    click_link "Edit"
    fill_in "name",	with: "New Equipment"
    click_button "Submit"
    expect(page).to have_content "Equipment edited."
  end

  scenario "removes an equipment", js: true do
    user = create :user
    create :equipment, user_id: user.id
    create_admin_and_login

    visit equipment_index_path
    click_button ":"
    click_link "Remove"
    page.driver.browser.switch_to.alert.accept
    expect(page).to have_content "Equipment deleted."
  end

  scenario "views admin dashboard" do
    create_admin_and_login
    visit admin_root_path
    expect(page).to have_content "Dashboard"
  end
end
