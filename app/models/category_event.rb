class CategoryEvent < ActiveRecord::Base
  belongs_to :event, :dependent => :destroy
  belongs_to :category, :dependent => :destroy
end
