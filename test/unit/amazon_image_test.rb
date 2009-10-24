require 'test_helper'

class AmazonImageTest < ActiveSupport::TestCase
  test 'required fields' do
    image = AmazonImage.new
    assert !image.valid?

    image.url          = 'http://example.com'
    image.height       = 5
    image.height_units = 'px'
    image.width        = 5
    image.width_units  = 'px'

    assert_valid image
  end

  test 'create valid' do
    i = AmazonImage.new(AmazonImage.plan)
    assert_valid i
    assert i.save
  end

  test 'amazon images can be associated with book editions' do
    i = AmazonImage.make
    b = BookEdition.make

    i.book_editions << b
    assert_valid i
    assert i.save

    i.reload
    assert_equal i.book_editions, [b]
  end
end
