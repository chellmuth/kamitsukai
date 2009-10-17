class BookEditionsUser < ActiveRecord::Base
  belongs_to :user
  belongs_to :book_edition
end
