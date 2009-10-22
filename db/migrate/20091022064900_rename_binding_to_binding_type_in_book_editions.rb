class RenameBindingToBindingTypeInBookEditions < ActiveRecord::Migration
  def self.up
    rename_column :book_editions, :binding, :binding_type
  end

  def self.down
    rename_column :book_editions, :binding_type, :binding
  end
end
