require 'rails_helper'

feature 'Create answer ajax' do
  
  given(:user) {create(:user)}
  given(:question){ create(:question)}

  scenario 'Auth user create answer', js: true do
    sign_in(user)
    visit question_path(question)

    fill_in 'answer_text', with: 'My answer'
    click_on 'Add'

    #save_and_open_page
    expect(current_path).to eq question_path(question)
    within '.answers' do
      expect(page).to have_content "My answer"
    end
  end

end