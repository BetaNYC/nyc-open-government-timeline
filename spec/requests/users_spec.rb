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

    it "signs a user in" do
      visit '/users/sign_in'
      within(".container") do
        fill_in 'Email', :with => 'jasper@example.com'
        fill_in 'Password', :with => 'password'
      end
      click_button 'Sign in'
      expect(page).to have_content 'Government Timeline'
    end
  end

  describe "user sign out", :type => :feature do

    before :each do
      User.create(:email => 'jasper@example.com', :password => 'adoptabunny')
    end

    it "signs a user out" do
      visit '/users/sign_out'
      expect(page).to have_content 'Government Timeline'
    end
  end


end