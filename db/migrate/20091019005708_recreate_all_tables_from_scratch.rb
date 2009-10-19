class RecreateAllTablesFromScratch < ActiveRecord::Migration
  def self.up
    drop_table :amazon_images
    drop_table :book_editions
    drop_table :book_editions_images
    drop_table :book_editions_users
    drop_table :books
    drop_table :friends_users
    drop_table :lent_books
    drop_table :roles
    drop_table :roles_users
    drop_table :sessions
    drop_table :settings
    drop_table :users

    create_table :amazon_images do |t|
      t.text     :url,          :null => false
      t.float    :height,       :null => false
      t.string   :height_units, :null => false
      t.float    :width,        :null => false
      t.string   :width_units,  :null => false

      t.timestamps
    end

    create_table :book_editions do |t|
      t.integer  :book_id,      :null  => false
      t.string   :isbn,         :limit => 13
      t.string   :ean,          :limit => 13
      t.string   :asin
      t.string   :binding
      t.float    :dewey_decimal
      t.text     :publisher
      t.date     :published
      t.date     :released
      t.text     :studio
      t.integer  :pages
      t.integer  :height
      t.string   :height_units
      t.integer  :length
      t.string   :length_units
      t.integer  :width
      t.string   :width_units
      t.text     :detail_page_url

      t.timestamps
    end

    create_table :books do |t|
      t.text     :title, :null => false
      t.timestamps
    end

    create_table :book_editions_images, :id => false do |t|
      t.references :book_edition, :null => false
      t.references :amazon_image, :null => false
    end
    add_index :book_editions_images, [:book_edition_id, :amazon_image_id], :unique => true, :name => 'unq_book_editions_images_edition_image'
    add_index :book_editions_images, [:book_edition_id]
    add_index :book_editions_images, [:amazon_image_id]

    create_table :book_editions_users, :id => false do |t|
      t.references :book_edition, :null => false
      t.references :user,         :null => false
    end
    add_index :book_editions_users, [:book_edition_id]
    add_index :book_editions_users, [:user_id]

    create_table :friends_users, :id => false do |t|
      t.references  :user,   :null => false
      t.references  :friend, :null => false
    end
    add_index :friends_users, [:user_id, :friend_id], :unique => true
    add_index :friends_users, [:user_id]
    add_index :friends_users, [:friend_id]

    create_table :lent_books do |t|
      t.references  :book_editions_user, :null => false
      t.references  :lent_to_user,       :null => false
      t.datetime :due_at
      t.timestamps
    end
    add_index :lent_books, [:book_editions_user_id]
    add_index :lent_books, [:lent_to_user_id]

    create_table :roles do |t|
      t.string     :name,         :null        => false
      t.belongs_to :authorizable, :polymorphic => true
      t.timestamps
    end

    create_table :roles_users do |t|
      t.references  :user, :null => false
      t.references  :role, :null => false
      t.timestamps
    end
    add_index :roles_users, [:user_id, :role_id], :unique => true
    add_index :roles_users, [:user_id]
    add_index :roles_users, [:role_id]

    create_table :sessions do |t|
      t.string   :session_id, :limit => 600, :null => false
      t.text     :data
      t.timestamps
    end
    add_index :sessions, [:session_id], :name => :index_sessions_on_session_id
    add_index :sessions, [:updated_at], :name => :index_sessions_on_updated_at

    create_table :settings do |t|
      t.string   :key,  :null => false
      t.string   :value
      t.timestamps
    end
    add_index :settings, [:key], :unique => true

    create_table :users do |t|
      t.string   :username,          :null => false
      t.string   :email,             :null => false
      t.string   :crypted_password,  :null => false
      t.string   :password_salt,     :null => false
      t.string   :persistence_token, :null => false
      t.timestamps
    end
  end

  def self.down
  end
end
