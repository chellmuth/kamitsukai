class BookEdition < ActiveRecord::Base
  validates_presence_of :book

  belongs_to :book
  has_many :users,
    :through => :book_editions_users
end
