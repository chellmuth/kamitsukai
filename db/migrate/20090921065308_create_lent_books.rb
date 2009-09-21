class CreateLentBooks < ActiveRecord::Migration
  def self.up
    create_table :lent_books do |t|
      t.references :lender
      t.references :lendee
      t.references :book_edition
      t.datetime :due_at

      t.timestamps
    end
  end

  def self.down
    drop_table :lent_books
  end
end
