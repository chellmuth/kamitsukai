class User < ActiveRecord::Base
  acts_as_authentic
  attr_accessible :username, :email, :password, :password_confirmation

  has_many :book_editions,
    :through => :book_editions_users,
    :include => :book
  has_and_belongs_to_many :friends,
    :class_name              => 'User',
    :association_foreign_key => 'friend_id'
  has_and_belongs_to_many :friend_of,
    :class_name              => 'User',
    :foreign_key             => 'friend_id',
    :association_foreign_key => 'user_id'
end
