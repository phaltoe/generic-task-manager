require_relative '../../rails_helper'

feature 'User creates a new project', :type => :feature do
  given!(:user) { FactoryGirl.create(:user) }

  scenario 'sees the page for the created project' do
    sign_in(user)
    visit new_project_path
    fill_in "Title", :with => "My new project"
    fill_in "Description", :with => "My new project description goes here"
    click_button "Create project"
    expect(page).to have_content("My new project")
  end

  # scenario 'invite friends to a project' do
  #   sign_in(user)
  #   visit new_project_path
  #   fill_in "Title", :with => "My new project"
  #   fill_in "Description", :with => "My new project's description."
  #   # fill in or check checkboxes of users to invite
  # end
end
