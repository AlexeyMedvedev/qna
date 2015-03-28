require 'rails_helper'

feature 'Show questions', %q{
  To order read questions list
  as any role user
  able to view all questions
} do 
  
  scenario 'User able to view all questions' do
    question1 = create(:question)
    question2 = create(:question)

    visit questions_path
    #save_and_open_page
    expect(page).to have_content question1.topic
    expect(page).to have_content question2.topic
  end

end
 