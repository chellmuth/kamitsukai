class LentBook < ActiveRecord::Base
  belongs_to :library_book,
    :class_name => 'BookEditionsUser'
  belongs_to :lent_to,
    :class_name  => 'User',
    :foreign_key => 'lent_to_user_id'
end
