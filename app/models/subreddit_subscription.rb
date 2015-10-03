class SubredditSubscription < ActiveRecord::Base

  belongs_to :subreddit
  belongs_to :user

end
