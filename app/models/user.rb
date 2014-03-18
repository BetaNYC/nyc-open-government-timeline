class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable

  attr_accessible :email, :password, :admin

  devise :database_authenticatable, :recoverable, :rememberable, :trackable, :validatable, :lockable
  
end
