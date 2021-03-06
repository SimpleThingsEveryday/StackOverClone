require 'rails_helper'
feature 'Create question' , %q{
    In order to get answer from community
  As an authenticated user
  I want to be able to ask questions
} do
  scenario 'Authenicated user creates question' do
    User.create!(email: 'user@test.com', password: '1234567890')
    visit new_user_session_path
    fill_in 'Email', with: 'user@test.com'
    fill_in 'Password' , with: '1234567890'
    visit questions_path
    click_on 'Ask question'
    fill_in 'Title', with: 'test question'
    fill_in 'Body', with: 'test body'
    click_on 'Create'

    expect(page).to have_content 'Your question successfully created.'

  end
    scenario 'Non-authenticated user  ties to create question' do
      visit questions_path
      click_on 'Ask question'
      expect(page).to have_content 'You need to sign in or sign up before continuing.'
    end
end