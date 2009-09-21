class BookEdition < ActiveRecord::Base
  validates_presence_of :book

  belongs_to :book
  has_and_belongs_to_many :users
end
