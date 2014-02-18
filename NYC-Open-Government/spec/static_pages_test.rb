require 'spec_helper'

describe "Static pages" do 

  describe "Home page" do 

    it "should have the content 'NYC Open Government Timeline'" do 
      visit '/home'
      expect(page).to have_content('NYC Open Government Timeline')
    end
  
end