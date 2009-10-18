class RemoveIdFromFriendsUsers < ActiveRecord::Migration
  def self.up
    remove_column :friends_users, :id
  end

  def self.down
  end
end
