class Comment < ActiveRecord::Base
  attr_accessible :content, :author, :event_id
  belongs_to :event
  validates :content, :presence => true, :length => { :maximum => 400, :minimum => 3, :message => "must be 3-400 characters in length"}
  validates :author, :presence => true, :length => { :maximum => 20, :minimum => 2, :message => "must be 2-20 characters in length"}
end
