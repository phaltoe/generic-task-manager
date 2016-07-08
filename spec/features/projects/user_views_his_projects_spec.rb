require_relative '../../rails_helper'

feature 'User views his projects', :type => :feature do
  given!(:user) { FactoryGirl.create(:user) }
  given!(:project) { FactoryGirl.create(:project, :owner => user, :title => "See me") }
  given!(:user2) { FactoryGirl.create(:user) }
  given!(:project2) { FactoryGirl.create(:project, :owner => user2, :title => "Don't see me") }

  scenario 'user sees his projects' do
      sign_in(user)
      visit root_path
      click_link 'My Projects'
      expect(page).to have_content("See me")
  end

  scenario 'user doesnt see other users projects' do
      sign_in(user)
      visit root_path
      click_link 'My Projects'
      expect(page).not_to have_content("Don't see me")
  end
end
