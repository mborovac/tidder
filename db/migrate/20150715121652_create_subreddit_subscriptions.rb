class CreateSubredditSubscriptions < ActiveRecord::Migration
  def change
    create_table :subreddit_subscriptions do |t|
      t.integer :user_id
      t.integer :subreddit_id

      t.timestamps null: false
    end
  end
end
