require 'test_helper'

class UserSessionsControllerTest < ActionController::TestCase
  def test_new
    get :new
    assert_template 'new'
    assert_not_nil assigns(:user_session)
  end

  def test_create_invalid
    post :create, {
      :username => 'user',
      :password => 'wrong password'
    }
    assert_template 'new'
  end

  def test_create_valid
    post :create, {
      :username => 'user',
      :password => 'user_password'
    }
    assert_not_nil assigns(:user_session)

    # TODO: Figure out if this is a real problem, or just not knowing
    # how to test.
    #assert_redirected_to root_url, @response.location.to_s
  end
end
