require_relative 'acceptance_helper'

feature 'Select accept', %q{
  In order to select best answer
  as question author
  able to mark answer in question as best
} do

  given(:user) {create(:user)}
  given(:anuser){create(:user)}
  given(:question){ create(:question)}
  given!(:answer){ create(:answer, question: question, user: user) }
  
  scenario 'Author see best link', js: true do
    sign_in(user)
    visit question_path(question)
    expect(page).to have_link 'Best'
  end

  scenario 'Author select answer as best', js: true do
    sign_in(user)
    visit question_path(question)
    within '.answers' do

      click_on 'Best'
      expect(page).to have_selector '.answer-accept '
    end
  end

  scenario 'Unauth user try to edit', js: true do
    visit question_path(question)

    within '.answers' do
      expect(page).to_not have_link 'Best'
    end
  end
end