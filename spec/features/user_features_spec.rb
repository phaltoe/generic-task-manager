require_relative '../rails_helper.rb'

# *Signup for the website*
# As a visitor the website
# I want to sign up for an account and get access instantly
# So that I can create projects and share them with my friends right away
feature 'User signup', :type => :feature do
  scenario 'visitor signs up for an account with email' do
    visit root_path
    click_link 'Sign up'
    fill_in 'Email', with: 'test@example.org'
    fill_in 'Username', with: "myUserName"
    fill_in 'Password', with: 'test1234'
    fill_in 'Password confirmation', with: 'test1234'
    click_button 'Sign up'
    expect(User.count).to eq(1)
    expect(current_path).to eq('/')
    expect(page).to have_content('Sign out')
  end

  scenario 'visitor cannot signup for an account without a unique email' do
    user = FactoryGirl.create(:user, :email => 'test@example.org', :profile => nil)
    visit root_path
    click_link 'Sign up'
    fill_in 'Email', with: user.email
    fill_in 'Username', with: 'myUserName'
    fill_in 'Password', with: 'test1234'
    fill_in 'Password confirmation', with: 'test1234'
    click_button 'Sign up'
    expect(User.count).to eq(1)
    expect(current_path).not_to eq('/')
    expect(page).to have_content('has already been taken')
  end

  scenario 'visitor signs up for an account with github'
  scenario 'visitor signs up for an account with github when email already registered'
  scenario 'visitor signs up for an accoutn with email when already registered with github account'
end

# As a registered user
# I want to login to my account
# So I can start creating projects and contributing to my friends projects
feature "User login and logout", :type => :feature do
  scenario 'a registered user logs into their account with email' do
    user = FactoryGirl.create(:user, :email => 'test@example.org')
    visit root_path
    click_link 'Login'
    fill_in 'Email', :with => user.email
    fill_in 'Password', :with => user.password
    click_button 'Log in'
    expect(current_path).to eq('/')
    expect(page).to have_content('Sign out')
  end

  scenario 'a user that has been deleted cannot login to their account' do
    inactive_user = FactoryGirl.create(:user, :email => 'test@example.org', active: false)
    visit root_path
    click_link 'Login'
    fill_in 'Email', :with => inactive_user.email
    fill_in 'Password', :with => inactive_user.password
    click_button 'Log in'
    expect(page).to have_content('Invalid Email')
  end

  scenario 'a user that has been banned cannot login to their account'

  scenario 'a logged in user logsout' do
    user = FactoryGirl.create(:user, :email => 'test@example.org')
    visit root_path
    click_link 'Login'
    fill_in 'Email', :with => user.email
    fill_in 'Password', :with => user.password
    click_button 'Log in'
    click_link 'Sign out'
    expect(current_path).to eq(root_path)
    expect(page).to have_content('Signed out')
  end
end

feature "User updates their profile", :type => :feature do
end
