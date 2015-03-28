require 'rails_helper'

feature 'Question answers show', %q{
  In order view questions and all answers
  as user
  able to show question and answers list
} do
  
  scenario 'User view question and answers' do
    question = create(:question)
    answer1 = create(:answer, question: question)
    answer2 = create(:answer, question: question)

    visit question_path(question)

    expect(page).to have_content question.topic
    expect(page).to have_content question.text
    expect(page).to have_content answer1.text
    expect(page).to have_content answer2.text

    #save_and_open_page
  end

end