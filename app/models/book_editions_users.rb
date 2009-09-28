class BookEditionsUsers < ActiveRecord::Base
  belongs_to :user
  belongs_to :book_edition
end
