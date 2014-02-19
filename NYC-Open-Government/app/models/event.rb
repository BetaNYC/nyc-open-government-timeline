class EventValidator < ActiveModel::Validator
  def validate(my_event)
    if my_event.category == "select one"
      my_event.errors[:base] << "Please select a category."
    end
  end
end

class Event < ActiveRecord::Base
  attr_accessible :date, :name, :category, :description, :status, :url
  has_many :comments
  validates :date, :presence => true
  validates :name, :presence => true,  :length => { :maximum => 150, :minimum => 2, :message => "must be 2-150 characters in length"}
  validates :category, :presence => true
  validates :description, :presence => true, :length => { :maximum => 700, :minimum => 25, :message => "must be 25-700 characters in length"}
  validates_with EventValidator
end
