# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of Active Record to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20091024172836) do

  create_table "amazon_images", :force => true do |t|
    t.text     "url",          :null => false
    t.float    "height",       :null => false
    t.string   "height_units", :null => false
    t.float    "width",        :null => false
    t.string   "width_units",  :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "book_editions", :force => true do |t|
    t.integer  "book_id",                       :null => false
    t.string   "isbn",            :limit => 13
    t.string   "ean",             :limit => 13
    t.string   "asin"
    t.string   "binding_type"
    t.float    "dewey_decimal"
    t.text     "publisher"
    t.date     "published"
    t.date     "released"
    t.text     "studio"
    t.integer  "pages"
    t.integer  "height"
    t.string   "height_units"
    t.integer  "length"
    t.string   "length_units"
    t.integer  "width"
    t.string   "width_units"
    t.text     "detail_page_url"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "book_editions_images", :id => false, :force => true do |t|
    t.integer "book_edition_id", :null => false
    t.integer "amazon_image_id", :null => false
  end

  add_index "book_editions_images", ["amazon_image_id"], :name => "index_book_editions_images_on_amazon_image_id"
  add_index "book_editions_images", ["book_edition_id", "amazon_image_id"], :name => "unq_book_editions_images_edition_image", :unique => true
  add_index "book_editions_images", ["book_edition_id"], :name => "index_book_editions_images_on_book_edition_id"

  create_table "book_editions_users", :force => true do |t|
    t.integer  "book_edition_id"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "books", :force => true do |t|
    t.text     "title",      :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "friends_users", :id => false, :force => true do |t|
    t.integer "user_id",   :null => false
    t.integer "friend_id", :null => false
  end

  add_index "friends_users", ["friend_id"], :name => "index_friends_users_on_friend_id"
  add_index "friends_users", ["user_id", "friend_id"], :name => "index_friends_users_on_user_id_and_friend_id", :unique => true
  add_index "friends_users", ["user_id"], :name => "index_friends_users_on_user_id"

  create_table "lent_books", :force => true do |t|
    t.integer  "book_editions_user_id", :null => false
    t.integer  "lent_to_user_id",       :null => false
    t.datetime "due_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "lent_books", ["book_editions_user_id"], :name => "index_lent_books_on_book_editions_user_id"
  add_index "lent_books", ["lent_to_user_id"], :name => "index_lent_books_on_lent_to_user_id"

  create_table "roles", :force => true do |t|
    t.string   "name",              :null => false
    t.integer  "authorizable_id"
    t.string   "authorizable_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "roles_users", :force => true do |t|
    t.integer  "user_id",    :null => false
    t.integer  "role_id",    :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "roles_users", ["role_id"], :name => "index_roles_users_on_role_id"
  add_index "roles_users", ["user_id", "role_id"], :name => "index_roles_users_on_user_id_and_role_id", :unique => true
  add_index "roles_users", ["user_id"], :name => "index_roles_users_on_user_id"

  create_table "sessions", :force => true do |t|
    t.string   "session_id", :limit => 600, :null => false
    t.text     "data"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "sessions", ["session_id"], :name => "index_sessions_on_session_id"
  add_index "sessions", ["updated_at"], :name => "index_sessions_on_updated_at"

  create_table "settings", :force => true do |t|
    t.string   "key",        :null => false
    t.string   "value"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "settings", ["key"], :name => "index_settings_on_key", :unique => true

  create_table "users", :force => true do |t|
    t.string   "username",          :null => false
    t.string   "email",             :null => false
    t.string   "crypted_password",  :null => false
    t.string   "password_salt",     :null => false
    t.string   "persistence_token", :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
