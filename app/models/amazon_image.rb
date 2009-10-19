class AmazonImage < ActiveRecord::Base
  has_and_belongs_to_many :book_editions,
    :validate => false

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
