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

  scenario 'invites friends by email to project' do
    create(:user, :email => 'daniela@example.com')
    sign_in(user)
    visit new_project_path
    fill_in "Title", :with => "My new project"
    fill_in "Description", :with => "My new project description!"
    fill_in "Enter the emails you want to invite", :with => "daniela@example.com, lucas@example.com"
    click_button "Create project"
    click_link "View project team"
    # TODO
    # find a matcher to make sure that this email appears in the right area of the 
    # layout (Invited users, not Active users, whatever that ends up looking like.)
    expect(page).to have_content("daniela@example.com")
  end

  scenario 'invites friends by email to project and is notified of invalid invited emails' do
    create(:user, :email => 'daniela@example.com')
    sign_in(user)
    visit new_project_path
    fill_in "Title", :with => "My new project"
    fill_in "Description", :with => "My new project description!"
    fill_in "Enter the emails you want to invite", :with => "brokenemail"
    click_button "Create project"
    click_link "View project team"
    expect(page).to have_content("The following invalid emails were not invited: brokenemail")
  end
end
