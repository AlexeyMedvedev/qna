require_relative 'acceptance_helper'

feature 'Add files to question' do 

  given(:user) {create(:user)}
  given(:question) { create(:question) }

  background do
    sign_in(user)
    visit new_question_path
  end
  
  scenario 'User adds file when asks question' do
    fill_in 'Topic', with: question.topic
    fill_in 'Text', with: question.text

    attach_file 'File', "#{Rails.root}/spec/spec_helper.rb"

    click_on 'Create'

    #save_and_open_page
    expect(page).to have_link 'spec_helper.rb', href: '/uploads/attachment/file/1/spec_helper.rb'
  end

end