require 'spec_helper'

describe 'A User' do
  it "should create a new instance given valid attributes" do
    u = User.new(User.plan)
    u.should be_valid
    u.save.should be_true
  end

  it 'should be invalid without username and email' do
    u = User.new(User.plan(:username => nil, :email => nil))
    u.should_not be_valid
    u.username = 'Foo'
    u.email    = 'foo@example.com'
    u.should be_valid
  end

  it 'should be able to own book editions' do
    user = User.make
    book_editions = [
      BookEdition.make,
      BookEdition.make,
      BookEdition.make
    ]

    user.should have(:no).book_editions

    user.book_editions << book_editions[0]
    user.reload

    user.should have(1).book_editions
    user.book_editions.should     include(book_editions[0])
    user.book_editions.should_not include(book_editions[1])
    user.book_editions.should_not include(book_editions[2])

    user.book_editions << book_editions[1]
    user.reload

    user.should have(2).book_editions
    user.book_editions.should     include(book_editions[0])
    user.book_editions.should     include(book_editions[1])
    user.book_editions.should_not include(book_editions[2])

    user.book_editions << book_editions[2]
    user.reload

    user.should have(3).book_editions
    user.book_editions.should     include(book_editions[0])
    user.book_editions.should     include(book_editions[1])
    user.book_editions.should     include(book_editions[2])
  end

  context 'and its friends' do
    before(:each) do
      @user           = User.make
      @friend         = User.make
      @another_friend = User.make
    end

    after(:each) do
      @user.destroy
      @friend.destroy
      @another_friend.destroy
    end

    it 'should be able to see who it considers a friend' do
      @user.should have(:no).friends

      @user.friends << @friend
      @user.reload

      @user.should have(1).friends
      @user.friends.should     include(@friend)
      @user.friends.should_not include(@another_friend)

      @user.friends << @another_friend
      @user.reload

      @user.should have(2).friends
      @user.friends.should include(@friend)
      @user.friends.should include(@another_friend)
    end

    it 'should be able to see who considers it a friend' do
      @user.should have(:no).friend_of

      @friend.friends << @user
      @user.reload

      @user.should have(1).friend_of
      @user.friend_of.should     include(@friend)
      @user.friend_of.should_not include(@another_friend)

      @another_friend.friends << @user
      @user.reload

      @user.should have(2).friend_of
      @user.friend_of.should include(@friend)
      @user.friend_of.should include(@another_friend)
    end
  end
end
