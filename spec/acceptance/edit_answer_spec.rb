require_relative 'acceptance_helper'

feature 'Answer editing', %q{
  In order to change Answer
  as answer owner
  able to edit answer
}do
  
  given(:user) {create(:user)}
  given(:anuser){create(:user)}
  given(:question){ create(:question)}
  given!(:answer){ create(:answer, question: question, user: user) }

  scenario 'Unauth try to edit' do
    visit question_path(question)
    within '.answers' do
      expect(page).to_not have_link 'Edit'
    end
  end

 # scenario 'Auth user try to edit other user answer' do
 #   sign_in(anuser)
 #   visit question_path(question)

 #   within '.answers' do
 #     expect(page).to_not have_link 'Edit'
 #   end
 # end

  describe 'Auth user' do
    before do
      sign_in(user)
      visit question_path(question)
    end

    scenario 'see link to edit' do
    
      #save_and_open_page
      within '.answers' do
        expect(page).to have_link 'Edit'
      end
    end

    scenario 'edit answer', js: true do
      within '.answers' do
        click_on 'Edit'
        fill_in 'Answer', with: 'Edited answer'
        click_on 'Save'
        expect(page).to_not have_content answer.text
        expect(page).to have_content 'Edited answer'
        expect(page).to_not have_selector 'textarea'
      end
    end

    scenario 'try to edit other user answer' do

    end

  end

end