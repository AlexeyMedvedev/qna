require 'rails_helper'

feature 'Create question', %q{
  In order to ask new question
  as Authentified_User
  able to create question
}do 

  scenario 'Authentified_User able create new question'do
    User.create!(email: 'reguser@fake.ru', password: '12345678')

    visit new_user_session_path
    fill_in 'Email', with: 'reguser@fake.ru'
    fill_in 'Password', with: '12345678'
    click_on 'Log in'

    visit questions_path
    click_on 'Create new question'
    fill_in 'Topic', with: 'Question 1'
    fill_in 'Text', with: 'Text 1'
    click_on 'Create'

    expect(page).to have_content 'Your question successfully created.'
  end

  scenario 'Unauthentified_User able create new question'do
    visit questions_path
    click_on 'Create new question'

    expect(page).to have_content 'You need to sign in or sign up before continuing.'
  end
  
end