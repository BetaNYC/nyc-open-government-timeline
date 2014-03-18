require 'spec_helper'

describe "User resource pages" do 

  describe "create" do 
    it "should have the content 'Sign in'" do 
      visit '/users/sign_in'
      expect(page).to have_content('Sign in')
    end
  end

  describe "user sign in", :type => :feature do

    before :each do
      User.create(:email => 'jasper@example.com', :password => 'adoptabunny')
    end

    it "sign a user in" do
      visit '/sessions/new'
      within("#session") do
        fill_in 'Login', :with => 'jasper@example.com'
        fill_in 'Password', :with => 'password'
      end
      click_link 'Sign in'
      expect(page).to have_content 'NYC’s Open Data & Government Timeline'
    end
  end

end