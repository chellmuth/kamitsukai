class BookEdition < ActiveRecord::Base
  validates_presence_of :book
  belongs_to :book
end
