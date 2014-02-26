class EventValidator < ActiveModel::Validator
  def validate(my_event)
    if my_event.categories.collect{|cat|cat.name}.length == 0
      my_event.errors[:base] << "Please select at least one category for this event"
    end
  end
end

class Event < ActiveRecord::Base
  attr_accessible :date, :name, :categories, :description, :status, :url, :categories_attributes
  has_many :comments
  has_many :category_events
  has_many :categories, :through => :category_events
  
  validates :categories, :presence => true
  validates :date, :presence => true
  validates :name, :presence => true,  :length => { :maximum => 150, :minimum => 2, :message => "must be 2-150 characters in length"}
  validates :description, :presence => true, :length => { :maximum => 700, :minimum => 5, :message => "must be 5-700 characters in length"}
  validates_with EventValidator

  accepts_nested_attributes_for :categories
  
  def self.make_events
    Parser.new('lib/events.csv').add_to_database
  end

end
