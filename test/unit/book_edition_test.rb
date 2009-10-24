require 'test_helper'

class BookEditionTest < ActiveSupport::TestCase
  test 'create valid book edition' do
    b = Book.make
    e = BookEdition.new(BookEdition.plan(:book => b))

    assert_valid e
    assert e.save

    e.reload
    assert_equal e.book(true), b
  end

  test 'cannot create book edition without associated book' do
    e = BookEdition.new
    assert !e.valid?
  end

  test 'book editions can be associated with users' do
    u = User.make
    b = BookEdition.make

    b.users << u
    assert_valid b
    assert b.save

    b.reload
    assert_equal b.users, [u]
  end

  test 'book editions can be associated with amazon images' do
    i = AmazonImage.make
    b = BookEdition.make

    b.images << i
    assert_valid b
    assert b.save

    b.reload
    assert_equal b.images, [i]
  end
end
