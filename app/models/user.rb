class User < ActiveRecord::Base
  acts_as_authentic
  attr_accessible :username, :email, :password, :password_confirmation

  has_and_belongs_to_many :book_editions, :include => :book
end
