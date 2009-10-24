require 'spec_helper'

describe 'A Book' do
  it 'should be created with valid options' do
    b = Book.new(Book.plan)
    b.should be_valid
    b.save.should be_true
  end

  it 'should be invalid without a title' do
    b = Book.new
    b.should_not be_valid

    b.title = 'Foo'
    b.should be_valid

    b.save.should be_true
  end

  it 'should be associated with multiple BookEdition' do
    book = Book.make
    book_editions = [
      BookEdition.make,
      BookEdition.make,
      BookEdition.make
    ]

    book.should have(:no).editions

    book.editions << book_editions[0]
    book.reload

    book.should have(1).editions
    book.editions.should     include(book_editions[0])
    book.editions.should_not include(book_editions[1])
    book.editions.should_not include(book_editions[2])

    book.editions << book_editions[1]
    book.reload

    book.should have(2).editions
    book.editions.should     include(book_editions[0])
    book.editions.should     include(book_editions[1])
    book.editions.should_not include(book_editions[2])

    book.editions << book_editions[2]
    book.reload

    book.should have(3).editions
    book.editions.should include(book_editions[0])
    book.editions.should include(book_editions[1])
    book.editions.should include(book_editions[2])
  end
end
