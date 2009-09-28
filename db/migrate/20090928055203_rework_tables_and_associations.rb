class ReworkTablesAndAssociations < ActiveRecord::Migration
  def self.up
    create_table :book_editions_users, :force => true do |t|
      t.integer  :book_editions_id
      t.integer  :users_id
      t.timestamps
    end

    create_table :books, :force => true do |t|
      t.text     :title
      t.timestamps
    end

    create_table :friends_users, :force => true do |t|
      t.references :users
      t.references :friends
      t.timestamps
    end

    create_table :lent_books, :force => true do |t|
      t.references :book_editions_users
      t.references :lent_to_user
      t.datetime   :due_at
      t.timestamps
    end
  end

  def self.down
    create_table :book_editions_users, :force => true do |t|
      t.integer  :book_editions_id
      t.integer  :users_id
      t.datetime :created_at
      t.datetime :updated_at
    end

    create_table :books, :force => true do |t|
      t.text     :title
      t.datetime :created_at
      t.datetime :updated_at
    end

    create_table :friends_users, :force => true do |t|
      t.integer  :user_id
      t.integer  :friend_id
      t.datetime :created_at
      t.datetime :updated_at
    end

    create_table :lent_books, :force => true do |t|
      t.integer  :lender_id
      t.integer  :lendee_id
      t.integer  :book_edition_id
      t.datetime :due_at
      t.datetime :created_at
      t.datetime :updated_at
    end
  end
end
