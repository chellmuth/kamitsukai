class LentBook < ActiveRecord::Base
  belongs_to :lender, :class_name => 'Users'
  belongs_to :lendee, :class_name => 'Users'
  belongs_to :book_edition
end
