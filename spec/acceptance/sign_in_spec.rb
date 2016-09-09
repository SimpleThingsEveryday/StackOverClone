require 'rails_helper'
feature 'User sign in', %q{
In order to  be able to ask question
as an user
I want to ba able to sign in
} do
  scenario 'Registered user try to sign in' do
    User.create!(email: 'user@test.com', password: '1234567890')

    visit new_user_session_path
    fill_in 'Email', with: 'user@test.com'
    fill_in 'Password' , with: '1234567890'
    save_and_open_page
    click_on 'Log in'
    expect(page).to have_content 'Signed in successfully.'
    expect(current_path).to eq root_path

  end
  scenario ' Non-registred user try to sign in' do
    visit new_user_session_path
    fill_in 'Email', with: 'user2 @test.com'
    fill_in 'Password' , with: '1234567890'
    save_and_open_page
    click_on 'Log in'
    expect(page).to have_content 'Invalid Email or password. Log in Email Password Remember me Sign up Forgot your password?'
    expect(current_path).to eq new_user_session_path
    save_and_open_page
  end
end