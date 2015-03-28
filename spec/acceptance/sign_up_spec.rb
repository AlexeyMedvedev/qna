require 'rails_helper'

feature 'User sign-up', %q{
  In order to be Authintificate User
  as User
  able to sign-up
}do
  
  given(:user){ create(:user) }

  scenario 'New User sign-up' do
    visit new_user_registration_path

    fill_in 'Email', with: 'newuser@fake.ru'
    fill_in 'Password', with: '123456789'
    fill_in 'Password confirmation', with: '123456789'
    click_on 'Sign up'

    #save_and_open_page

    expect(page).to have_content 'Welcome! You have signed up successfully.'

    visit new_user_session_path
    expect(current_path).to eq root_path
  end

  scenario 'User exist' do
    visit new_user_registration_path
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    fill_in 'Password confirmation', with: user.password_confirmation
    click_on 'Sign up'

     expect(page).to have_content 'Email has already been taken'
  end

end