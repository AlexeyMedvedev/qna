require_relative 'acceptance_helper'

feature 'Delete files from answer' do
  given(:user) {create(:user)}
  given (:anuser) { create(:user) }
  given(:question) { create(:question) }
  given(:answer) {create(:answer, question: question, user: user)} 
  given!(:attachment) { create(:attachment, attachmentable: answer) }

  scenario 'Auth user see delete link for own answer' do
    sign_in(user)
    visit question_path(question)

    expect(page).to have_selector '.answer-attach-delete'
    within '.answer-attach-delete' do
      expect(page).to have_link 'Delete'
    end
  end

  scenario 'Auth user delete own attach file', js: true do
    sign_in(user)
    visit question_path(answer.question)
    within '.answer-attach-delete' do
      click_on 'Delete'
    end
    expect(page).to_not have_link 'spec_helper.rb'
  end

  scenario 'Auth user cant see delete link for other user answer' do
    sign_in(anuser)
    visit question_path(question)

    expect(page).to_not have_selector '.answer-attach-delete'
  end 

end