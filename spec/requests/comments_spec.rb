# comments_spec.rb

require 'spec_helper'

describe "Comments" do 
  describe "New" do
    it "should have content 'Your handle'" do
      visit '/events/1/comments/new'
      expect(page).to have_content('Your handle')
    end  
  end
end