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
end
