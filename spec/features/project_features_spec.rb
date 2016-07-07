require_relative '../rails_helper.rb'

# As a user
# I want to see a list of my projects
# So I can work with them
feature 'View Projects', :type => :feature do
  given!(:user) { FactoryGirl.create(:user) }
  given!(:project) { FactoryGirl.create(:project, :owner => user, :title => "See me") }
  given!(:user2) { FactoryGirl.create(:user) }
  given!(:project2) { FactoryGirl.create(:project, :owner => user2, :title => "Don't see me") } 

# Given I am a signed in user
# When I click on the My Projects link
# Then I see a list of the projects I own or belong to
  scenario 'user sees his projects and not other peoples projects' do
      sign_in(user)
      visit root_path
      click_link 'My Projects'
      expect(page).to have_content("See me")
      expect(page).not_to have_content("Don't see me")
  end

# Given I am a signed in user
# When I click on the my Projects link
# Then I see a button to Create a new project
  scenario 'user sees link to create a new project' do
    sign_in(user)
    visit root_path
    click_link 'My Projects'
    expect(page).to have_button('Create new project')
  end
end

# As a user
# I want to create new projects
# So I can invite other users and do cool things
feature 'Create new projects', :type => :feature do
  given!(:user) { FactoryGirl.create(:user) }

  # Given I am signed in and on the new project page
  # When I add a new project
  # I see the newly created projects page
  # And the notice 'Your new project has been created!'
  scenario 'create new project with valid attributes' do
    sign_in(user)
    visit new_project_path
    fill_in "Title", :with => "My new project"
    fill_in "Description", :with => "My new project description goes here"
    click_button "Create project"
    expect(page).to have_content("My new project")
    expect(page).to have_content("Your new project has been created!")
  end

  # Given I am signed in and on the new project page
  # When I add a new project
  # And enter the emails of my friends
  # I see the newly created projects page
  # And a list of invited users
  # And a list of invited emails that have not registered on the site yet
end

# Given I am the owner and on the show project page
# When I click 'remove' by a users name
# I see the projects page and the users name is gone

# Given I am the owner and on the show project page
# When I click role: 'leader' by a users name
# I see the projects page and the users role is now leader

# Given I am the owner and on the show project page
# When I click 'Invite users to this project' link
# I see the form to invite users by their emails

# Given I am the owner and on the invite to project page
# When I fill in the form with my friends emails who are not members
# And I click 'Invite users'
# I see the project show page
# And I see my friends emails listed as 'Not yet registered'
