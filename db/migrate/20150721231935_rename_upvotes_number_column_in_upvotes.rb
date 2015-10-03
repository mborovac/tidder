class RenameUpvotesNumberColumnInUpvotes < ActiveRecord::Migration
  def change
    rename_column :upvotes, :upvotes_number, :user_id
  end
end
