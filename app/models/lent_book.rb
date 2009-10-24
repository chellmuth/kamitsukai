class LentBook < ActiveRecord::Base
  belongs_to :library_book,
    :class_name  => 'BookEditionsUser',
    :foreign_key => :book_editions_user_id
  belongs_to :lent_to,
    :class_name  => 'User',
    :foreign_key => :lent_to_user_id

  def validate
    errors.add_on_empty %w( library_book )
  end
end
