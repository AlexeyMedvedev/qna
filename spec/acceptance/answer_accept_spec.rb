require_relative 'acceptance_helper'

feature 'Select accept', %q{
  In order to select best answer
  as question author
  able to mark answer in question as best
} do

  given(:user) {create(:user)}
  given(:anuser){create(:user)}
  given(:question){ create(:question)}
  given!(:answer){ create(:answer, question: question, user: user, text: 'Answer text') }
  
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

  scenario 'Selected best answer first on page', js: true do
    answers = create_list(:answer, 2, user: user, question: question)
   
    sign_in(user)

    visit question_path(question)
    within "#answer-#{answer.id}" do
      click_on 'Best'
    end

    first_answer_on_page = page.find('.answer:first-child')

    expect(page).to have_selector('.answer', count: 3)
    expect(first_answer_on_page).to have_content answer.text
  end

  scenario 'New selected best first on page', js: true do
    answer2 = create(:answer, question: question, user: user)
    answer3 = create(:answer, question: question, user: user, accepted: true, text: 'Old best answer')
    
    sign_in(user)
    visit question_path(question)
    within "#answer-#{answer.id}" do
      click_on 'Best'
    end

    first_answer_on_page = page.find('.answer:first-child')

    expect(first_answer_on_page).to have_content answer.text
    expect(page.find('.answer-accept')).to_not have_content answer3.text
       
  end

end