require 'test_helper'

class BookEditionTest < ActiveSupport::TestCase
  test 'create valid book edition' do
    b = Book.make
    e = BookEdition.new(BookEdition.plan(:book => b))

    assert_valid e
    assert e.save
    assert_equal e.book(true), b
  end

  test 'create book edition without associated book' do
    e = BookEdition.new
    assert !e.valid?
  end
end
