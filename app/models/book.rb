class Book < ActiveRecord::Base
  validates_presence_of :title

  has_many :editions, :class_name => 'BookEdition'
end
