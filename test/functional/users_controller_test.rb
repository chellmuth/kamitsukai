require 'test_helper'

class UsersControllerTest < ActionController::TestCase
  fixtures :users

  def test_new
    get :new
    assert_template 'new'
  end

  def test_create_invalid
    post :create, {
      :user => {
        :username              => Faker::Name.name,
        :email                 => Faker::Internet.email,
        :password              => 'password',
        :password_confirmation => 'does not match'
      }
    }
    assert_template 'new'
  end

  def test_create_valid
    post :create, {
      :user => {
        :username              => 'my name',
        :email                 => 'my_email@example.com',
        :password              => 'password',
        :password_confirmation => 'password'
      }
    }
    assert_valid assigns(:user)
    assert_redirected_to root_url
  end

  def test_edit
    login
    get :edit
    assert_template 'edit'
  end

  def test_update_invalid
    u = login
    put :update, {
      :user => {
        :username              => u.username,
        :email                 => u.email,
        :password              => 'password',
        :password_confirmation => 'does_not_match'
      }
    }
    assert_template 'edit'
  end

  def test_update_valid
    u = login
    put :update, {
      :user => {
        :username              => u.username,
        :email                 => u.email,
        :password              => 'password',
        :password_confirmation => 'password'
      }
    }
    assert_redirected_to root_url
  end
end
