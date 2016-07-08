require_relative '../../rails_helper'

feature 'User signs up for an account', :type => :feature do
  scenario 'visitor signs up for an account with email' do
    visit root_path
    click_link 'Sign up'
    fill_in 'Email', with: 'test@example.org'
    fill_in 'Username', with: "myUserName"
    fill_in 'Password', with: 'test1234'
    fill_in 'Password confirmation', with: 'test1234'
    click_button 'Sign up'
    expect(page).to have_content('Welcome! You have signed up successfully.')
  end
end
