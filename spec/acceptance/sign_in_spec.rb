require 'rails_helper'

feature 'User sign-in', %q{
  In order be Authentified_User
  as Guest_User
  Guest_User able to sign-in
}do

  given(:user){ create(:user) }
  
  scenario 'Registred user try to sign-in' do
    #User.create!(email: 'reguser@fake.ru', password: '12345678')

    #visit new_user_session_path
    #fill_in 'Email', with: 'reguser@fake.ru'
    #fill_in 'Password', with: '12345678'
    
    #fill_in 'Email', with: user.email
    #fill_in 'Password', with: user.password

    #save_and_open_page
    #click_on 'Log in'
    sign_in(user)


    expect(page).to have_content 'Signed in successfully.'
    expect(current_path).to eq root_path
  end

  scenario 'Unregistred user try to sign-in' do
    
    visit new_user_session_path
    fill_in 'Email', with: 'unreguser@fake.ru'
    fill_in 'Password', with: '123456'
    click_on 'Log in'

    #save_and_open_page
    expect(page).to have_content 'Invalid email or password.'
    expect(current_path).to eq new_user_session_path
  end
end