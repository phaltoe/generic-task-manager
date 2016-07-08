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

  # invites friends by email to project
  scenario 'invites friends by email to project' do
    sign_in(user)
    visit new_project_path
    fill_in "Title", :with => "My new project"
    fill_in "Description", :with => "My new project description!"
    fill_in "Enter the emails you want to invite", :with => "daniela@example.com, lucas@example.com"
    click_button "Create project"
    expect(page).to have_content("daniela@example.com: Invitation sent")
  end 
end
