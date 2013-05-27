class CreateFollowers < ActiveRecord::Migration
  def change
    create_table :followers do |t|
      t.integer :twitter_user_id, :twitter_follower_id
      t.timestamps
    end
  end
end
