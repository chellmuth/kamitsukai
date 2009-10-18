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
    assert !user.friends(true).empty?
    assert_equal user.friends(true).first, friend
  end
end
