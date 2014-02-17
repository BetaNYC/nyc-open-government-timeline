class Event < ActiveRecord::Base
  has_many :comments
end
