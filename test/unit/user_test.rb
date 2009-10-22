require 'test_helper'

class UserTest < ActiveSupport::TestCase
  def test_should_be_valid
    u = User.new
    u.username              = 'test user'
    u.email                 = 'email@example.com'
    u.password              = 'test user password'
    u.password_confirmation = 'test user password'
    assert_valid u
  end

  test 'users have friends' do
    user = User.make
    friend = User.make

    assert user.friends(true).empty?

    user.friends << friend
    user.reload
    assert !user.friends().empty?
    assert_equal user.friends().first, friend
  end

  test 'users are friends of other users' do
    user = User.make
    friend = User.make
    another_friend = User.make

    assert user.friend_of(true).empty?

    friend.friends << user
    another_friend.friends << user

    user.reload

    assert !user.friend_of().empty?
    assert_equal user.friend_of, [friend, another_friend]
  end
end
