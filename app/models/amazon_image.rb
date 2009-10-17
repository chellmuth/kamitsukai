class AmazonImage < ActiveRecord::Base
  has_many :book_editions_images
  has_many :book_editions,
    :through => :book_editions_images

  def validate
    errors.add_on_empty %w(
      url
      height
      height_units
      width
      width_units
    )
  end
end
