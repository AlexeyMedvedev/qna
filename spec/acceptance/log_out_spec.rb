require 'rails_helper'

feature 'User sign out' do

  given(:user) { create :user }

  scenario 'Authorized sign out' do

    sign_in(user)

    visit questions_path

    click_on 'Sign out'
    expect(page).to have_content 'Signed out successfully.'

  end
end