require 'test_helper'

class Admin::SettingsControllerTest < ActionController::TestCase
  def setup
    @user = login
    @user.has_role :administrator
    @settings = []
    (1..5).to_a.each do
      @settings.push(Setting.make)
    end
  end

  test 'redirects to login without a user' do
    logout
    get :index
    assert_redirected_to '/login'
  end

  test 'redirects to root without an administrator user' do
    @user.has_no_role :administrator
    get :index
    assert_redirected_to '/'
  end

  test 'allows administrator users' do
    get :index
    assert_response :success
  end

  test 'index' do
    get :index

    settings = assigns(:settings)
    assert_not_nil settings
    assert_equal settings.count, 5, "Should find 5 settings"
  end

  test 'show' do
    setting = @settings.first

    get :show, { :id => setting.id }

    assert_response :success

    found_setting = assigns(:setting)
    assert_not_nil found_setting
    assert_equal found_setting, setting
  end

  test 'new' do
    get :new
    assert_response :success

    assert assigns(:setting)
    assert assigns(:setting).new_record?
  end

  test 'create valid setting' do
    setting = Setting.plan

    put :create, {
      :setting => {
        :key   => setting[:key],
        :value => setting[:value]
      }
    }

    new_setting = assigns(:setting)
    assert_equal Setting.count, 6, "There can only be six"
    assert_equal new_setting.key, setting[:key]
    assert_equal new_setting.value, setting[:value]
  end

  test 'create invalid setting' do
    setting = Setting.plan

    put :create, {
      :setting => {
        :key   => setting[:key]
      }
    }

    new_setting = Setting.all
    assert_equal new_setting.count, 5, "Shouldn't have created anything"
  end

  test 'edit' do
    s = @settings.first

    get :edit, { :id => s.id }
    assert_response :success

    setting = assigns(:setting)
    assert_equal setting, s
  end

  test 'update valid setting' do
    setting = @settings.first

    put :update, {
      :id => setting.id,
      :setting => {
        :key   => setting.key + 'abcd',
        :value => setting.value + 'abcd'
      }
    }

    new_setting = assigns(:setting)
    assert_equal flash[:notice], "Successfully updated setting."
    assert_equal Setting.count, 5, "There can only be one"
    assert_equal new_setting.key, setting.key + 'abcd'
    assert_equal new_setting.value, setting.value + 'abcd'
  end

  test 'update invalid setting' do
    setting = @settings.first

    put :update, {
      :id => setting.id,
      :setting => {
        :key   => setting.key + 'abcd',
        :value => nil
      }
    }

    new_setting = Setting.all
    assert_equal new_setting.count, 5, "There can only be five"
    assert_equal new_setting.first.key, setting.key
    assert_equal new_setting.first.value, setting.value
    assert_template 'edit'
    assert_response :success
  end

  test 'destroy existing setting' do
    setting = @settings.first

    assert_equal Setting.count, 5

    delete :destroy, { :id => setting.id }

    assert Setting.count, 4
    assert_equal flash[:notice], 'Setting successfully removed.'
  end

  test 'destroy non-existant setting' do
    setting = @settings.last

    assert_equal Setting.count, 5

    delete :destroy, { :id => setting.id+1 }

    assert Setting.count, 5
    assert_equal flash[:notice], 'Unable to remove setting.'
  end
end
