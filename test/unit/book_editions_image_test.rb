require 'test_helper'

class BookEditionsImageTest < ActiveSupport::TestCase
  test "relates to book editions and amazon images" do
    book    = Book.make
    edition = BookEdition.make(:book => book)
    image   = AmazonImage.make

    edition_image = BookEditionsImage.new(
      :amazon_image => image,
      :book_edition => edition
    )

    assert_valid edition_image
    assert edition_image.save
  end
end
