require 'spec_helper'

describe 'A LentBook' do
  it 'should create a new instance given valid attributes' do
    lent_book = LentBook.new(LentBook.plan)
    lent_book.should be_valid
    lent_book.save.should be_true
  end

  it 'should not be valid without a library_book' do
    library_book = BookEditionsUser.make
    user = User.make
    lent_book = LentBook.new(:lent_to => user)
    lent_book.should_not be_valid

    lent_book.library_book = library_book
    lent_book.should be_valid

    lent_book.save.should be_true
  end
end
