class User < ActiveRecord::Base
  acts_as_authentic
  acts_as_authorized_user
  acts_as_authorizable
  attr_accessible :username, :email, :password, :password_confirmation

  has_many :book_editions_users
  has_many :book_editions,
    :through => :book_editions_users,
    :include => :book
  has_and_belongs_to_many :friends,
    :class_name              => 'User',
    :join_table              => :friends_users,
    :foreign_key             => :user_id,
    :association_foreign_key => :friend_id
  has_and_belongs_to_many :friend_of,
    :class_name              => 'User',
    :join_table              => :friends_users,
    :foreign_key             => :friend_id,
    :association_foreign_key => :user_id

  def validate
    errors.add_on_empty %w( username email )
  end
end
