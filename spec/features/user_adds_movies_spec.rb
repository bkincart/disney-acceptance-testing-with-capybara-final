require "spec_helper"

feature "user has a list of movies", focus: true do

  # User Story
  # ----------
  # As a user
  # I want to add a movie to my list
  # So that I can track which movies I've watched

  # Acceptance Criteria
  # -------------------
  # * I must enter a title
  # * I must enter a release year
  # * I must enter a runtime
  # * If I forget a field, errors are displayed

  before(:each) do
    reset_csv
  end

  context "create" do
    scenario "user creates a movie" do
      visit '/'

      click_link 'Add a Movie'

      fill_in 'Title', with: 'Peter Pan'
      fill_in 'Release Year', with: '1953'
      fill_in 'Runtime', with: '76 minutes'

      click_button 'Submit'

      expect(page).to have_content('Peter Pan')
    end

    scenario "user leaves a field blank" do
      visit '/'

      click_link 'Add a Movie'

      fill_in 'Title', with: 'Peter Pan'
      fill_in 'Release Year', with: '1953'

      click_button 'Submit'

      expect(page).to have_content('Please fill in all fields')
    end
  end
end
