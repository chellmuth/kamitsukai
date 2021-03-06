class BookEdition < ActiveRecord::Base
  belongs_to :book
  has_many :book_editions_users
  has_many :users,
    :through => :book_editions_users
  has_and_belongs_to_many :images,
    :class_name => 'AmazonImage',
    :join_table => :book_editions_images

  def validate
    errors.add_on_empty %w( book )
  end
end
