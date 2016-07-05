require_relative '../rails_helper.rb'

# As a user
# I want to see a list of my projects
# So I can work with them
feature 'List projects', :type => :feature do
  scenario 'user clicks on projects tab' do
    user = FactoryGirl.create(:user)
    project = FactoryGirl.create(:project, :owner => user, :title => "See me")
    user2 = FactoryGirl.create(:user)
    project2 = FactoryGirl.create(:project, :owner => user2, :title => "Don't see me")

    sign_in(user)
    visit root_path
    click_link 'My Projects'
    expect(page).to have_content("See me")
    expect(page).not_to have_content("Don't see me")
  end
end
