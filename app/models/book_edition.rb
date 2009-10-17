class BookEdition < ActiveRecord::Base
  belongs_to :book
  has_many :book_editions_users
  has_many :users,
    :through => :book_editions_users
  has_many :book_editions_images
  has_many :images,
    :through => :book_editions_images,
    :source  => :amazon_image

  def validate
    errors.add_on_empty %w( book )
  end

  def find_or_create_by_isbn(isbn)
  end
end
