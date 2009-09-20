require 'test_helper'

class UsersControllerTest < ActionController::TestCase
  fixtures :users

  # TODO: Figure out how to test these, since they depend on
  # UserSessions.

  #def test_new
  #  get :new
  #  assert_template 'new'
  #end

  #def test_create_invalid
  #  User.any_instance.stubs(:valid?).returns(false)
  #  post :create
  #  assert_template 'new'
  #end

  #def test_create_valid
  #  post :create, {
  #    :user => {
  #      :username              => 'my name',
  #      :email                 => 'my_email@example.com',
  #      :password              => 'password',
  #      :password_confirmation => 'password'
  #    }
  #  }
  #  assert_valid assigns(:user)
  #  assert_redirected_to root_url
  #end

  #def test_edit
  #  get :edit
  #  assert_template 'edit'
  #end

  #def test_update_invalid
  #  User.any_instance.stubs(:valid?).returns(false)
  #  put :update, :id => User.first
  #  assert_template 'edit'
  #end

  #def test_update_valid
  #  User.any_instance.stubs(:valid?).returns(true)
  #  put :update, :id => User.first
  #  assert_redirected_to root_url
  #end
end
