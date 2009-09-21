class CreateBookEditionsUsers < ActiveRecord::Migration
  def self.up
    create_table :book_editionss_users do |t|
      t.references :book_editions
      t.references :users

      t.timestamps
    end
  end

  def self.down
    drop_table :book_editions_users
  end
end
