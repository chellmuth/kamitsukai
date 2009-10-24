class ReCreateBookEditionsUsers < ActiveRecord::Migration
  def self.up
    create_table :book_editions_users, :force => true do |t|
      t.references :book_edition
      t.references :user

      t.timestamps
    end
  end

  def self.down
    create_table :book_editions_users, :id => false, :force => true do |t|
      t.references :book_edition
      t.references :user
    end
  end
end
