require_relative 'acceptance_helper'

feature 'Question edit', %q{
  In order to change Question
  as question owner
  able to edit question
}do
  
  given(:user){ create(:user)}
  given(:anuser){create(:user)}
  given(:question){ create(:question, user: user)}

  scenario 'Unauth user try to edit' do
    visit question_path(question)

    within '.question' do
      expect(page).to_not have_link 'Edit'
    end
  end

  scenario 'Auth user try to edit' do
    sign_in(user)
    visit question_path(question)

    within '.question' do
      expect(page).to have_link 'Edit'
    end
  end

  scenario 'Auth user edit question', js: true do
    sign_in(user)
    visit question_path(question)

    within '.question' do
      click_on 'Edit'
      fill_in 'question_topic', with: 'New topic'
      fill_in 'question_text', with: 'New text'
      click_on 'Save'

      expect(page).to have_content 'New topic'
      expect(page).to have_content 'New text'
      expect(page).to_not have_content question.topic
      expect(page).to_not have_content question.text
      expect(page).to_not have_selector 'textarea'

    end
  end

  #scenario 'Auth user try to edit other user question' do
  #  sign_in(anuser)
  #  visit question_path(question)
  #  within '.question' do
  #    expect(page).to_not have_link 'Edit'
  #  end
  #end
end