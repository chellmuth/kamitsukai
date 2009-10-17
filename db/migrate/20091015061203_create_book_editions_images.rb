class CreateBookEditionsImages < ActiveRecord::Migration
  def self.up
    create_table :book_editions_images do |t|
      t.references :book_edition
      t.references :amazon_image

      t.timestamps
    end
  end

  def self.down
    drop_table :book_editions_images
  end
end
