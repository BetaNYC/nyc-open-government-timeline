class EventValidator < ActiveModel::Validator
  def validate(my_event)
    if my_event.categories.collect{|cat|cat.name}.include?("select one")
      my_event.errors[:base] << "Please select a category."
    end
  end
end

class Event < ActiveRecord::Base
  attr_accessible :date, :name, :category, :description, :status, :url
  has_many :comments
  has_many :category_events
  has_many :categories, :through => :category_events
  
  validates :date, :presence => true
  validates :name, :presence => true,  :length => { :maximum => 150, :minimum => 2, :message => "must be 2-150 characters in length"}
  validates :category, :presence => true
  validates :description, :presence => true, :length => { :maximum => 700, :minimum => 5, :message => "must be 5-700 characters in length"}
  validates_with EventValidator

  def self.make_events
    Parser.new('lib/events.csv').add_to_database
  end

end
