require_relative '../../rails_helper'

feature "User logs in and out", :type => :feature do
  scenario 'a registered user logs into their account with email' do
    user = create(:user, :email => 'test@example.org')
    visit root_path
    click_link 'Login'
    fill_in 'Email', :with => user.email
    fill_in 'Password', :with => user.password
    click_button 'Log in'
    expect(page).to have_content('Signed in successfully')
  end

  scenario 'a registered user logs out of their account' do
    user = create(:user, :email => 'test@example.org')
    sign_in(user)
    click_link 'Sign out'
    expect(page).to have_content('Signed out successfully')
  end
end
