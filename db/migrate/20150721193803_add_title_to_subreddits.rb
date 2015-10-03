class AddTitleToSubreddits < ActiveRecord::Migration
  def change
    add_column :subreddits, :title, :string
  end
end
