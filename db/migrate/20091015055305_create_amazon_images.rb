class CreateAmazonImages < ActiveRecord::Migration
  def self.up
    create_table :amazon_images do |t|
      t.text   :url
      t.float  :height
      t.string :height_units
      t.float  :width
      t.string :width_units

      t.timestamps
    end
  end

  def self.down
    drop_table :amazon_images
  end
end
