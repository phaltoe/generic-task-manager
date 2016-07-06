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

  # Given I am a signed in user
  # And I fill in the new project form with a title and description
  # When I click create project
  # A new project is created and I am the owner
  scenario 'create new project with valid attributes' do
    sign_in(user)
    visit new_project_path
    save_and_open_page
    fill_in "Title", :with => "My new project"
    fill_in "Description", :with => "My new project description goes here"
    expect {
      click_button "Create project"
    }.to change(Project, :count).by(1)
    expect(user.projects.size).to eq(1)
  end
end
