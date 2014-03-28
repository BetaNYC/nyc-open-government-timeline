require 'spec_helper'

describe "Event resource pages" do 

  describe "New" do 
    it "should have the content 'Create new event'" do 
      visit '/events/new'
      expect(page).to have_content('Create new event')
    end

    it "should have the title 'NYC Open Government Timeline | New Timeline Event'" do
      visit '/events/new'
      expect(page).to have_title("NYC Open Government Timeline | New Timeline Event")
    end
  end

  describe "Index" do 

    it "supports javaScript", :js => true do
      visit events_path
      click_link "test_js"
      page.should have_content("js works")
    end

    it "should have the content 'Timeline'" do
      visit '/events'
      expect(page).to have_content('Timeline')
    end
  end
end
