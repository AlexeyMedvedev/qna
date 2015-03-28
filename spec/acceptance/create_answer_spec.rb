require 'rails_helper'

feature 'Create answer', %q{
  In order to have question's answer
  as Authorised_User
  able to create answer for question
} do
  
  given(:user){ create(:user) }
  given(:question){ create(:question) }

  scenario 'Authorised_User create answer for question' do
    sign_in(user)

    visit question_path(question)

    #save_and_open_page
    fill_in 'answer_text', with: 'text answer'
    click_on 'Add'
    
    expect(page).to have_content question.topic
    expect(page).to have_content question.text
    expect(page).to have_content 'text answer'

  end

  scenario 'Unauthorised_User create answer' do
    visit question_path(question)
    expect(page).to_not have_css('div.answer_new')
  end
end