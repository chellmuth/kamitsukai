require 'test_helper'

class AmazonImageTest < ActiveSupport::TestCase
  test "required fields" do
    image = AmazonImage.new
    assert !image.valid?

    image.url          = 'http://example.com'
    image.height       = 5
    image.height_units = 'px'
    image.width        = 5
    image.width_units  = 'px'

    assert_valid image
  end
end
