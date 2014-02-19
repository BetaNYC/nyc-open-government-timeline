# category.rb

class Category < ActiveRecord::Base
  attr_accessible :name

  has_many :category_events
  has_many :events, :through => :category_events 
end