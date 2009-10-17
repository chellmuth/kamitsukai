class BookEditionsImage < ActiveRecord::Base
  belongs_to :book_edition
  belongs_to :amazon_image
end
