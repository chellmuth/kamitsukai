class CreateBookEditions < ActiveRecord::Migration
  def self.up
    create_table :book_editions do |t|
      t.references :book,     :null  => false
      t.string :isbn,         :limit => 13
      t.string :ean,          :limit => 13
      t.string :asin,         :limit => 255
      t.string :binding,      :limit => 255
      t.float :dewey_decimal
      t.text :publisher
      t.date :published
      t.date :released
      t.text :studio
      t.integer :pages
      t.integer :height
      t.string :height_units, :limit => 255
      t.integer :length
      t.string :length_units, :limit => 255
      t.integer :width
      t.string :width_units,  :limit => 255
      t.text :detail_page_url

      t.timestamps
    end
  end

  def self.down
    drop_table :book_editions
  end
end
