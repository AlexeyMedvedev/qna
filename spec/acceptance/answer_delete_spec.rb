require_relative 'acceptance_helper'

feature 'Delete question', %q{
  In order to remove question from list
  as Authrised_User and Question owner
  able to delete question
}do
  
  given(:user){create (:user)}
  given(:anuser){create(:user)}
  given(:question){create :question, user: user}

  scenario 'Auth user able to delete own question'do
    answer = create(:answer, question: question, user: user)
 
    sign_in(user)
    visit question_path(question)

    #save_and_open_page
    click_on 'Delete answer'
    expect(page).to have_content 'Answer successfully deleted.'

    expect(page).to have_no_content answer.text
    expect(current_path).to eq question_path(question)

   end

  scenario 'Auth user unable to delete other user question' do
    answer = create(:answer, question: question, user: user)
 
    sign_in(anuser)
    visit question_path(question)

    expect(page).to_not have_content 'Delete answer'
  end

  scenario 'Unauth user unable to delete question' do
    answer = create(:answer, question: question, user: user)
 
    visit question_path(question)

    expect(page).to_not have_content 'Delete answer'
  end
end