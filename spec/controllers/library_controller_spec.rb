require 'spec_helper'

describe LibraryController do
  it 'should use LibraryController' do
    controller.should be_an_instance_of(LibraryController)
  end

  describe 'with a logged in user' do
    before(:each) do
      @user = login
    end

    describe "GET 'index'" do
      it 'should redirect to the show action' do
        get :index
        response.should redirect_to(user_library_url(:username => @user))
      end
    end

    describe "GET 'show'" do
      it 'should be successful' do
        get :show, { :username => @user.username }
        response.should be_success
      end

      it 'should assign library_entries' do
        get :show, { :username => @user.username }
        assigns(:library_entries).should_not be_nil
      end

      describe 'without any library_entries for the user' do
        it 'should assign an empty array to library_entries' do
          get :show, { :username => @user.username }
          assigns(:library_entries).should == []
        end
      end

      describe 'with library_entries for the user' do
        before(:each) do
          @book_editions = [
            BookEdition.make,
            BookEdition.make,
            BookEdition.make
          ]

          @book_editions_users = [
            BookEditionsUser.create(:user => @user,     :book_edition => @book_editions[0]),
            BookEditionsUser.create(:user => @user,     :book_edition => @book_editions[1]),
            BookEditionsUser.create(:user => User.make, :book_edition => @book_editions[2])
          ]
          @user.reload
        end

        it 'should assign all book_editions_users owned by the user' do
          get :show, { :username => @user.username }
          assigns(:library_entries).count.should be 2

          assigns(:library_entries).should     include(@book_editions_users[0])
          assigns(:library_entries).should     include(@book_editions_users[1])
          assigns(:library_entries).should_not include(@book_editions_users[2])
        end
      end
    end
  end

  describe 'without a logged in user' do
    before(:each) do
      logout
    end

    describe "GET 'index'" do
      it 'should ask the user to login' do
        get :index
        response.should redirect_to(login_url)
      end
    end

    describe "GET 'show'" do
      before(:each) do
        @user = User.make
      end

      it 'should be successful' do
        get :show, { :username => @user.username }
        response.should be_success
      end

      it 'should assign library_entries' do
        get :show, { :username => @user.username }
        assigns(:library_entries).should_not be_nil
      end

      describe 'without any library_entries for the user' do
        it 'should assign an empty array to library_entries' do
          get :show, { :username => @user.username }
          assigns(:library_entries).should == []
        end
      end

      describe 'with library_entries for the user' do
        before(:each) do
          @book_editions = [
            BookEdition.make,
            BookEdition.make,
            BookEdition.make
          ]

          @book_editions_users = [
            BookEditionsUser.create(:user => @user,     :book_edition => @book_editions[0]),
            BookEditionsUser.create(:user => @user,     :book_edition => @book_editions[1]),
            BookEditionsUser.create(:user => User.make, :book_edition => @book_editions[2])
          ]
          @user.reload
        end

        it 'should assign all book_editions_users owned by the user' do
          get :show, { :username => @user.username }
          assigns(:library_entries).count.should be 2

          assigns(:library_entries).should     include(@book_editions_users[0])
          assigns(:library_entries).should     include(@book_editions_users[1])
          assigns(:library_entries).should_not include(@book_editions_users[2])
        end
      end
    end
  end
end
