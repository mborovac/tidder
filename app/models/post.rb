class Post < ActiveRecord::Base

  belongs_to :subreddit
  belongs_to :user

  has_many :comments, dependent: :destroy
  has_many :upvotes, dependent: :destroy

  validates :title,  presence: true

  validates :content,  presence: true

  validates :subreddit_id,  presence: true

  scope :newest, -> { order('updated_at DESC') }

  scope :trending, -> { all.sort {|a,b| a.trend <=> b.trend}.reverse! }

  def trend
    points = upvotes_count
    time_since_submission = ((Time.now - created_at) / 1.hour).round
    gravity = 1.8
    (points) / (time_since_submission + 2)**gravity
  end

  def upvote(user)
    upvotes.create(post_id: id, user_id: user.id) if not upvotes.exists?(user_id: user.id)
  end
end
