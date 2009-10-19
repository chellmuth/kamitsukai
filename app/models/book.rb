class Book < ActiveRecord::Base
  has_many :editions,
    :class_name => 'BookEdition',
    :autosave   => true,
    :dependent  => :destroy

  def validate
    errors.add_on_empty %w( title )
  end
end
