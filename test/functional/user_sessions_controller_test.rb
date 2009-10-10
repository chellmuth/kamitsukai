require 'test_helper'

class UserSessionsControllerTest < ActionController::TestCase
  def test_new
    get :new
    assert_template 'new'
    assert_not_nil assigns(:user_session)
    assert_nil assigns(:user_session).record, "Should not assign a user to the session"
  end

  def test_create_invalid
    user = User.make(:password => 'my password')
    post :create, {
      :user_session => {
        :username => user.username,
        :password => 'your password'
      }
    }
    assert_template 'new'
    assert_not_nil assigns(:user_session)
    assert_nil assigns(:user_session).record, "Should not assign a user to the session"
    assert flash.empty?
  end

  def test_create_valid
    user = User.make
    post :create, {
      :user_session => {
        :username => user.username,
        :password => user.password
      }
    }
    sess = assigns(:user_session)
    assert_not_nil sess
    assert_not_nil sess.record, "Should assign the user to the session"
    assert_equal sess.record, user, "Assigned user should be the one trying to log in."

    assert_equal flash[:notice], "Successfully logged in."
    assert_redirected_to root_url, @response.location.to_s
  end

  def test_destroy
    u = login
    sess = UserSession.find
    assert_not_nil sess
    assert_not_nil sess.record, "Should have the user on the session"
    assert_equal sess.record, u, "Assigned user should be the one logged in."

    post :destroy

    assert_not_nil assigns(:user_session)
    assert_nil assigns(:user_session).record, "Should not assign a user to the session"
    assert_equal flash[:notice], "Successfully logged out."
  end
end
