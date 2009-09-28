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

ActiveRecord::Schema.define(:version => 20090928055203) do

  create_table "book_editions", :force => true do |t|
    t.integer  "book_id",                       :null => false
    t.string   "isbn",            :limit => 13
    t.string   "ean",             :limit => 13
    t.string   "asin"
    t.string   "binding"
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

  create_table "book_editions_users", :force => true do |t|
    t.integer  "book_editions_id"
    t.integer  "users_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "books", :force => true do |t|
    t.text     "title"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "friends_users", :force => true do |t|
    t.integer  "users_id"
    t.integer  "friends_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "lent_books", :force => true do |t|
    t.integer  "book_editions_users_id"
    t.integer  "lent_to_user_id"
    t.datetime "due_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "sessions", :force => true do |t|
    t.string   "session_id", :limit => 600, :null => false
    t.text     "data"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "sessions", ["session_id"], :name => "index_sessions_on_session_id"
  add_index "sessions", ["updated_at"], :name => "index_sessions_on_updated_at"

  create_table "users", :force => true do |t|
    t.string   "username"
    t.string   "email"
    t.string   "crypted_password"
    t.string   "password_salt"
    t.string   "persistence_token"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
