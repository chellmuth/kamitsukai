require 'spec_helper'

describe Admin::SettingsController do
  it "should use Admin::SettingsController" do
    controller.should be_an_instance_of(Admin::SettingsController)
  end

  describe 'without a logged in user' do
    it 'should redirect to the login page' do
      get :index
      response.should redirect_to('/login')
    end
  end

  describe 'with a logged in user' do
    before(:each) do
      @user = login
    end

    it 'should redirect home' do
      get :index
      response.should redirect_to('/')
    end

    describe 'that is an administrattor' do
      before(:each) do
        @user.has_role :administrator
      end

      it 'should allow access' do
        get :index
        response.should be_success
      end

      describe 'without existing settings' do
        describe 'the empty index' do
          it 'should be successful' do
            get :index
            response.should be_success
          end

          it 'should not list any settings' do
            get :index
            assigns(:settings).should be_empty
          end
        end
      end

      describe 'with existing settings' do
        before(:each) do
          @settings = []
          (1..5).to_a.each do
            @settings.push(Setting.make)
          end
        end

        after(:each) do
          @settings.each {|s| s.destroy}
        end

        describe 'the index' do
          it 'should be successful' do
            get :index
            response.should be_success
          end

          it 'should assign settings' do
            get :index
            assigns(:settings).should_not be_empty
          end
        end

        describe "GET 'show'" do
          it 'should be successful' do
            setting = @settings.rand

            get :show, {:id => setting.id}

            response.should be_succes
          end

          it 'should assign setting' do
            setting = @settings.rand

            get :show, {:id => setting.id}

            assigns(:setting).should_not be_nil
            assigns(:setting).should == setting
          end
        end
      end

      describe 'with invalid Setting options' do
      end

      describe 'with valid Setting options' do
        before(:each) do
          @setting = Setting.make
        end

        after(:each) do
          @setting.destroy
        end

        describe "GET 'new'" do
          before(:each) do
            Setting.stub!(:new).and_return(@new_setting = mock_model(Setting, :save => true))
          end

          it "should be successful" do
            get :new
            response.should be_success
          end

          it 'should assign setting' do
            get :new
            assigns(:setting).should == @new_setting
          end
        end

        describe "PUT 'update'" do
          def do_good_update
            put :update, {
              :id => @setting.id,
              :setting => {
                :key   => @setting.key + 'abcd',
                :value => @setting.value + 'abcd'
              }
            }
            @setting.reload
          end

          it 'should redirect to the setting' do
            do_good_update
            response.should redirect_to(admin_setting_url(@setting))
          end

          it 'should set a success flash message' do
            do_good_update
            flash[:notice].should == 'Successfully updated setting.'
          end

          it 'should not increase the Setting.count' do
            do_good_update
            Setting.should have(1).records
          end

          it 'should assign setting' do
            do_good_update
            assigns(:setting).should == @setting
          end
        end

        describe "GET 'edit'" do
          it "should be successful" do
            get :edit, {:id => @setting.id}
            response.should be_success
          end

          it 'should assign setting' do
            get :edit, {:id => @setting.id}
            assigns(:setting).should == @setting
          end
        end

        describe "PUT 'create'" do
          it 'should redirect to settings list' do
            put :create, { :setting => Setting.plan }
            response.should redirect_to(admin_settings_url)
          end

          it 'should create a new setting' do
            lambda {
              put :create, { :setting => Setting.plan }
            }.should change{ Setting.count }.from(1).to(2)
          end

          it 'should set a success flash message' do
            put :create, { :setting => Setting.plan }
            flash[:notice].should == 'Setting successfully created.'
          end
        end

        describe "DELETE 'destroy'" do
          it 'should redirect back to the settings list' do
            delete :destroy, { :id => @setting.id }
            response.should redirect_to(admin_settings_url)
          end

          it 'should set a success flash message' do
            delete :destroy, { :id => @setting.id }
            flash[:notice].should == 'Setting successfully removed.'
          end

          it 'should destroy the setting' do
            setting_id = @setting.id

            delete :destroy, { :id => @setting }
            lambda {
              Setting.find(setting_id)
            }.should raise_error(ActiveRecord::RecordNotFound)
          end
        end
      end

      describe 'with invalid Setting options' do
        before(:each) do
          @setting = Setting.make
        end

        after(:each) do
          @setting.destroy
        end

        describe "PUT 'update'" do
          def do_bad_update
            put :update, {
              :id => @setting.id,
              :setting => {
                :key   => nil,
                :value => @setting.value
              }
            }
            @setting.reload
          end

          it 'should be successful' do
            do_bad_update
            response.should be_success
          end

          it 'should render the edit template' do
            do_bad_update
            response.should render_template('edit')
          end

          it 'should not increase the Setting.count' do
            do_bad_update
            Setting.should have(1).records
          end

          it 'should assign setting' do
            do_bad_update
            assigns(:setting).should == @setting
          end

          it 'should not update the setting' do
            lambda {
              do_bad_update
            }.should_not change{@setting.key}
          end
        end

        describe "GET 'edit'" do
          it "should not be successful" do
            lambda {
              get :edit, {:id => @setting.id+1}
            }.should raise_error(ActiveRecord::RecordNotFound)
          end
        end

        describe "PUT 'create'" do
          def do_bad_create
            put :create, {
              :setting => {
                :key   => nil,
                :value => @setting.value
              }
            }
          end

          it 'should be successful' do
            do_bad_create
            response.should be_success
          end

          it 'should render the new template' do
            do_bad_create
            response.should render_template('new')
          end

          it 'should not create a new setting' do
            lambda {
              do_bad_create
            }.should_not change{ Setting.count }
          end
        end

        describe "DELETE 'destroy'" do
          def do_bad_delete
              delete :destroy, { :id => @setting.id+1 }
          end
          it 'should be successful' do
            do_bad_delete
            response.should redirect_to(admin_settings_url)
          end

          it 'should set a failure flash message' do
            do_bad_delete
            flash[:notice].should == 'Unable to remove setting.'
          end

          it 'should not destroy any setting' do
            lambda {
              do_bad_delete
            }.should_not change{ Setting.count }
          end
        end
      end
    end

    after(:each) do
      logout
      @user.destroy
    end
  end
end
