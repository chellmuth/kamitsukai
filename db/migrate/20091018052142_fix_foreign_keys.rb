class FixForeignKeys < ActiveRecord::Migration
  def self.up
    rename_column :friends_users, :users_id, :user_id
    rename_column :friends_users, :friends_id, :friend_id

    rename_column :book_editions_users, :book_editions_id, :book_edition_id
    rename_column :book_editions_users, :users_id, :user_id

    rename_column :lent_books, :book_editions_users_id, :book_editions_user_id
  end

  def self.down
    rename_column :friends_users, :user_id, :users_id
    rename_column :friends_users, :friend_id, :friends_id

    rename_column :book_editions_users, :book_edition_id, :book_editions_id
    rename_column :book_editions_users, :user_id, :users_id

    rename_column :lent_books, :book_editions_user_id, :book_editions_users_id
  end
end
