# comments_spec.rb

require 'spec_helper'

describe "Comments" do 

  describe "New" do
    it "should have content 'Your handle'" do
      visit '/events/1/comments/new'
      expect(page).to have_content('Your handle')
    end  
  end

  describe "Show" do
    it "should have content 'Author'" do
      visit '/events/1/comments/1'
      expect(page).to have_content('Author')
    end
  end
end