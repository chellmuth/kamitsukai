require 'spec_helper'

describe 'A BookEdition' do
  it 'should create a new instance given valid attributes' do
    book_edition = BookEdition.new(BookEdition.plan)
    book_edition.should be_valid
    book_edition.save.should be_true
  end

  it 'should be invalid without a Book' do
    book_edition = BookEdition.new
    book_edition.should_not be_valid

    book_edition.book = Book.make
    book_edition.should be_valid

    book_edition.save.should be_true
  end

  it 'should be able to retrieve the associated Book' do
    b = Book.make
    book_edition = BookEdition.make(:book => b)
    book_edition.reload

    book_edition.book.should == b
  end

  it 'should be able to be owned by multiple Users' do
    book_edition = BookEdition.make
    users = [
      User.make,
      User.make,
      User.make
    ]

    book_edition.should have(:no).users

    book_edition.users << users[0]
    book_edition.reload

    book_edition.should have(1).user
    book_edition.users.should     include(users[0])
    book_edition.users.should_not include(users[1])
    book_edition.users.should_not include(users[2])

    book_edition.users << users[1]
    book_edition.reload

    book_edition.should have(2).users
    book_edition.users.should     include(users[0])
    book_edition.users.should     include(users[1])
    book_edition.users.should_not include(users[2])

    book_edition.users << users[2]
    book_edition.reload

    book_edition.should have(3).users
    book_edition.users.should include(users[0])
    book_edition.users.should include(users[1])
    book_edition.users.should include(users[2])
  end

  it 'should be able to have multiple AmazonImages' do
    book_edition = BookEdition.make
    images = [
      AmazonImage.make,
      AmazonImage.make,
      AmazonImage.make
    ]

    book_edition.should have(:no).images

    book_edition.images << images[0]
    book_edition.reload

    book_edition.should have(1).image
    book_edition.images.should     include(images[0])
    book_edition.images.should_not include(images[1])
    book_edition.images.should_not include(images[2])

    book_edition.images << images[1]
    book_edition.reload

    book_edition.should have(2).images
    book_edition.images.should     include(images[0])
    book_edition.images.should     include(images[1])
    book_edition.images.should_not include(images[2])

    book_edition.images << images[2]
    book_edition.reload

    book_edition.should have(3).images
    book_edition.images.should include(images[0])
    book_edition.images.should include(images[1])
    book_edition.images.should include(images[2])
  end
end
