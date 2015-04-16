require_relative 'acceptance_helper'

feature 'Add files to answer' do 

  given(:user) {create(:user)}
  given(:question) { create(:question) }
  given(:answer) {create(:anwer, question: question, user: user)}

  background do
    sign_in(user)
    visit question_path(question)
  end
  
  scenario 'User adds file when asks question', js: true do
    fill_in 'Answer', with: 'Add answer'
        
    attach_file 'File', "#{Rails.root}/spec/spec_helper.rb"

    click_on 'Add'
    
    within '.answers' do
      expect(page).to have_link 'spec_helper.rb', href: '/uploads/attachment/file/1/spec_helper.rb'
    end

    
  end

scenario 'User adds 2 files when asks question', js: true do
    fields = page.all('input[type="file"]')

    fill_in 'Answer', with: 'Add answer'
        
    #attach_file 'File', "#{Rails.root}/spec/spec_helper.rb"
    fields[0].set "#{Rails.root}/spec/spec_helper.rb"
    click_on 'Add atachment'
    fields = page.all('input[type="file"]')
    fields[1].set "#{Rails.root}/spec/rails_helper.rb"

    click_on 'Add'
    
    within '.answers' do
      expect(page).to have_link 'spec_helper.rb', href: '/uploads/attachment/file/1/spec_helper.rb'
      expect(page).to have_link 'rails_helper.rb', href: '/uploads/attachment/file/2/rails_helper.rb'
    end

    
  end



end