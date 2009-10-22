class Book < ActiveRecord::Base
  has_many :editions,
    :class_name => 'BookEdition'

  def validate
    errors.add_on_empty %w( title )
  end
end
