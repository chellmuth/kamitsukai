require 'spec_helper'

describe UsersController do
  it 'should use UsersController' do
    controller.should be_an_instance_of(UsersController)
  end

  describe 'without a logged in user' do
    before(:each) do
      logout
    end

    describe "GET 'new'" do
      it 'should succeed' do
        get :new
        response.should be_success
      end

      it "should render the 'new' template" do
        get :new
        response.should render_template('new')
      end

      it 'should assign user' do
        get :new
        assigns(:user).should_not be_nil
        assigns(:user).should be_new_record
      end
    end

    describe "POST 'create'" do
      describe 'with valid attributes' do
        def do_create
          post :create, { :user => User.plan }
        end

        it 'should redirect to root_url' do
          do_create
          response.should redirect_to(edit_user_url('current'))
        end

        it 'should create a new instance of User' do
          lambda {
            do_create
          }.should change{ User.count }.from(0).to(1)
        end
      end

      describe 'with invalid attributes' do
        def do_create
          post :create, {
            :user => {
              :username              => Faker::Name.name,
              :email                 => Faker::Internet.email,
              :password              => 'password',
              :password_confirmation => 'does not match'
            }
          }
        end
        it "should render the 'new' template" do
          do_create
          response.should render_template('new')
        end

        it 'should not create a new instance of User' do
          do_create
          lambda {
            do_create
          }.should_not change{ User.count }
        end
      end
    end

    describe "GET 'edit'" do
      it 'should redirect to the login page' do
        get :edit
        response.should redirect_to('/login')
      end
    end

    describe "PUT 'update'" do
      before(:each) do
        @user = User.make
      end

      it 'should redirect to the login page' do
        pending 'Test thinks user is logged in' do
        put :update, { :user => User.plan }
        response.should redirect_to('/login')
        end
      end

      it 'should not store a success flash message' do
        pending 'Test thinks user is logged in' do
        put :update, { :user => User.plan }
        flash[:notice].should_not == 'Successfully updated profile.'
        end
      end

      it 'should not change the user' do
        lambda {
          put :update, {
            :user => {
              :username => @user.username,
              :email    => 'asdf' + @user.email
            }
          }
        }.should_not change{@user.email}
      end

      it 'should not assign user' do
        pending 'Test thinks user is logged in' do
        put :update, {
          :user => {
            :username => @user.username,
            :email    => 'asdf' + @user.email
          }
        }
        assigns(:user).should be_nil
        end
      end
    end
  end

  describe 'with a logged in user' do
    before(:each) do
      @user_plan = User.plan
      @user = login(@user_plan)
    end

    describe "GET 'new'" do
      it 'should redirect to account page' do
        get :new
        response.should redirect_to('/account')
      end
    end

    describe "POST 'create'" do
      it 'should redirect to account page' do
        post :create, { :user => User.plan }
        response.should redirect_to('/account')
      end

      it 'should not create a new instance of User' do
        lambda {
          post :create, { :user => User.plan }
        }.should_not change{ User.count }
      end
    end

    describe "GET 'edit'" do
      it 'should succeed' do
        get :edit
        response.should be_success
      end

      it 'should render the edit template' do
        get :edit
        response.should render_template('edit')
      end

      it 'should assign the logged in user' do
        get :edit
        assigns(:user).should_not be_nil
        assigns(:user).should == @user
      end
    end

    describe "PUT 'update'" do
      describe 'with valid attributes' do
        def do_update
          put :update, {
            :user => {
              :username => @user.username,
              :email    => 'asdf' + @user.email
            }
          }
        end

        it 'should redirect to the edit page' do
          do_update
          response.should redirect_to(edit_user_url('current'))
        end

        it 'should update the User instance' do
          lambda {
            do_update
            @user.reload
          }.should change{ @user.email }
        end

        it 'should set a success flash notice' do
          do_update
          flash[:notice].should == 'Successfully updated profile.'
        end
      end

      describe 'with invalid attributes' do
        def do_update
          put :update, {
            :user => {
              :username              => @user.username,
              :email                 => 'asdf' + @user.email,
              :password              => 'password',
              :password_confirmation => 'does not match'
            }
          }
        end

        it 'should render the edit template' do
          do_update
          response.should render_template('edit')
        end

        it 'should not update the User instance' do
          lambda {
            do_update
            @user.reload
          }.should_not change{ @user.email }
        end

        it 'should assign user' do
          do_update
          assigns(:user).should_not be_nil
          assigns(:user).should == @user
        end
      end
    end
  end
end
