class AddUpvotesCounterCacheToPost < ActiveRecord::Migration
  def change
    add_column :posts, :upvotes_count, :integer
  end
end
