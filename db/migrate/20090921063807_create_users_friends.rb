class CreateUsersFriends < ActiveRecord::Migration
  def self.up
    create_table :friends_users do |t|
      t.references :user
      t.references :friend

      t.timestamps
  end

  def self.down
  end
end
