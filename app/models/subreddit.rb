class Subreddit < ActiveRecord::Base

  has_many :posts, dependent: :destroy

  has_many :subreddit_subscriptions, dependent: :destroy
  has_many :users, :through => :subreddit_subscriptions, dependent: :destroy

  validates :name,  presence: true,
                    length: { minimum: 3,
                              maximum: 20 },
                    uniqueness: true

  validates :description, length: { maximum: 500 }

  scope :newest, -> { order('updated_at DESC') }

  scope :trending, -> { all.sort {|a,b| a.trend <=> b.trend}.reverse! }

  def trend
    points = users.count
    time_since_submission = ((Time.now - created_at) / 1.hour).round
    gravity = 1.8
    (points - 1.0) / (time_since_submission + 2)**gravity
  end

end
