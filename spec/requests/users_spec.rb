require 'spec_helper'

describe "User resource pages" do 

  describe "create" do 
    it "should have the content 'Sign in'" do 
      visit '/users/sign_in'
      expect(page).to have_content('Sign in')
    end
  end

  describe "home page", :type => :feature do

    before :each do
      User.create(:email => 'jasper@example.com', :password => 'adoptabunny')
    end

    it "signs a user in" do
      visit '/users/sign_in'
      within(".container") do
        fill_in 'Email', :with => 'jasper@example.com'
        fill_in 'Password', :with => 'adoptabunny'
      end
      click_button 'Sign in'
      expect(page).to have_selector(".alert-notice", :text => "Signed in successfully.")
    end
  end

  describe "user sign out", :type => :feature do

    it "signs a user out" do
      visit '/users/sign_in'
      within(".container") do
        fill_in 'Email', :with => 'jasper@example.com'
        fill_in 'Password', :with => 'adoptabunny'
      end
      click_button 'Sign in'
      visit '/users/sign_out'
      expect(page).to have_content("Signed out successfully.")
    end
  end

end