require 'rails_helper'

feature 'Delete question', %q{
  In order to remove question from list
  as Authrised_User and Question owner
  able to delete question
}do
  
  given(:user){create (:user)}
  given(:anuser){create(:user)}
  given(:question){create :question, user: user}

  scenario 'Auth user able to delete own question'do
    sign_in(user)
    visit question_path(question)

    click_on 'Delete'
    expect(page).to have_content 'You question successfully deleted.'

    expect(page).to have_no_content question.topic
    expect(current_path).to eq questions_path

   end

  scenario 'Auth user unable to delete other user question' do
    sign_in(anuser)
    visit question_path(question)

    expect(page).to_not have_content 'Delete'
  end

  scenario 'Unauth user unable to delete question' do
    visit question_path(question)

    expect(page).to_not have_content 'Delete'
  end
end