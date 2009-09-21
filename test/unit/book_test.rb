require 'test_helper'

class BookTest < ActiveSupport::TestCase
  test "cannot create a book without a title" do
    b = Book.new
    assert !b.save
  end

  test "create a book with a title" do
    b = Book.new(:title => "I'm a book!")
    assert b.save
  end
end
