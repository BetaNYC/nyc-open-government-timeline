require 'spec_helper'

describe "User resource pages" do 

  describe "create" do 
    it "should have the content 'Sign in'" do 
      visit '/users/sign_in'
      expect(page).to have_content('Sign in')
    end
  end

  describe "user sign in" do
    it "permits users to sign in once they have registered" do
      user = User.create(:email => "jasper@example.com", :password => "adoptabunny")

      visit "/users/sign_in"

      fill_in "Email",    :with => "jasper@example.com"
      fill_in "Password", :with => "adoptabunny"

      click_button "Sign in"

      page.should have_content("Signed in successfully.")
    end
  end

end