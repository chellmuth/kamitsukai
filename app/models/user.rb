class User < ActiveRecord::Base
  acts_as_authentic
  attr_accessible :username, :email, :password, :password_confirmation

  has_and_belongs_to_many :book_editions, :include => :book
  has_and_belongs_to_many :friends,
    :class_name => 'User',
    :association_foreign_key => 'friend_id'
  has_and_belongs_to_many :friend_of,
    :class_name => 'User',
    :foreign_key => 'friend_id',
    :association_foreign_key => 'user_id'
  has_many :lent_books,
    :foreign_key => 'lender_id'
  has_many :loaned_books,
    :class_name  => 'LentBook',
    :foreign_key => 'lendee_id'

end
