require 'spec_helper'

describe '/library/show' do
  before(:each) do
    user = mock_model(User)
    user.should_receive(:username).and_return('Bob')

    assigns[:user] = user
    assigns[:library_entries] = []
  end

  it 'should say whose library it is' do
    render 'library/show'

    response.should have_tag('h1', 'The library of Bob')
  end

  it 'should not have any tbody rows' do
    render 'library/show'

    response.should have_tag('tbody') do
      with_tag('tr', 0)
    end
  end

  describe 'when the user has library entries' do
    before(:each) do
      book1 = mock_model(Book)
      book1.should_receive(:title).twice.and_return('Book 1')
      book2 = mock_model(Book)
      book2.should_receive(:title).and_return('Book 2')

      book_edition1 = mock_model(BookEdition)
      book_edition1.should_receive(:released).and_return('2009-09-30')
      book_edition1.should_receive(:binding_type).and_return('Paperback')
      book_edition1.should_receive(:book).and_return(book1)

      book_edition2 = mock_model(BookEdition)
      book_edition2.should_receive(:released).and_return('2009-09-29')
      book_edition2.should_receive(:binding_type).and_return('Hardcover')
      book_edition2.should_receive(:book).and_return(book1)

      book_edition3 = mock_model(BookEdition)
      book_edition3.should_receive(:released).and_return('2009-09-01')
      book_edition3.should_receive(:binding_type).and_return('Paperback')
      book_edition3.should_receive(:book).and_return(book2)

      book_editions_user1 = mock_model(BookEditionsUser)
      book_editions_user1.should_receive(:book_edition).exactly(3).times.and_return(book_edition1)
      book_editions_user1.should_receive(:created_at).and_return('2009-10-30')

      book_editions_user2 = mock_model(BookEditionsUser)
      book_editions_user2.should_receive(:book_edition).exactly(3).times.and_return(book_edition2)
      book_editions_user2.should_receive(:created_at).and_return('2009-10-29')

      book_editions_user3 = mock_model(BookEditionsUser)
      book_editions_user3.should_receive(:book_edition).exactly(3).times.and_return(book_edition3)
      book_editions_user3.should_receive(:created_at).and_return('2009-10-01')

      assigns[:library_entries] = [
        book_editions_user1,
        book_editions_user2,
        book_editions_user3
      ]
    end

    it 'should list the book editions' do
      render 'library/show'

      response.should have_tag('tbody') do
        with_tag('tr') do
          with_tag('td', 'Book 1')
          with_tag('td', 'N/A')
          with_tag('td', '2009-09-30')
          with_tag('td', 'Paperback')
          with_tag('td', '2009-10-30')
        end
        with_tag('tr') do
          with_tag('td', 'Book 1')
          with_tag('td', 'N/A')
          with_tag('td', '2009-09-29')
          with_tag('td', 'Hardcover')
          with_tag('td', '2009-10-29')
        end
        with_tag('tr') do
          with_tag('td', 'Book 2')
          with_tag('td', 'N/A')
          with_tag('td', '2009-09-01')
          with_tag('td', 'Paperback')
          with_tag('td', '2009-10-01')
        end
      end
    end
  end
end
