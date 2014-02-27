# api_helper_spec.rb

require 'spec_helper'

describe ApiHelper do 
  describe 'clean_query' do
    it 'should return a downcased params query' do
      expect(clean_query("Hello")).to eq("hello")
    end
    it 'should return a params query with no %20s' do
      expect(clean_query("Hello%20World")).to eq("hello world")
    end
  end

  describe 'query_by_name' do 
    it 'should return an active record object for Event or Category' do
      expect(query_by_name(Category.all, "API").class).to eq(Category)  
    end

    it 'should find an active record object for Category based off of name query' do
      expect(query_by_name(Category.all, "API")).to eq(Category.find_by_name("API"))
    end

    it 'should find an active record object for Event based off of name query' do
      expect(query_by_name(Event.all, "FOIA signed into law")).to eq(Event.find_by_name("FOIA signed into law"))
    end

    it "should still return a query if name arg has %20s in it" do 
      expect(query_by_name(Category.all, "Federal%20Law")).to eq(Category.find_by_name("Federal Law"))
    end

    it "should still return a query if name arg is not properly capitalized" do 
      expect(query_by_name(Category.all, "federal law")).to eq(Category.find_by_name("Federal Law"))
    end
  end
end
