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
  
  scenario 'Author see best link'do
    sign_in(user)
    visit question_path(question)
    expect(page).to have_link 'Edit'
  end

  scenario 'Author select answer as best' do
    sign_in(user)
    visit question_path(question)
  end
end