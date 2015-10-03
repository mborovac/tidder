class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :subreddit_subscriptions, dependent: :destroy
  has_many :subreddits, :through => :subreddit_subscriptions, dependent: :destroy

  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy

  has_many :upvotes, dependent: :destroy

  before_create :generate_token

  enum gender: [:female, :male]

  has_attached_file :avatar, :styles => { :medium => "300x300>", :thumb => "150x150>" }, :default_url => ActionController::Base.helpers.asset_path('avatar.jpeg')

  validates_attachment_content_type :avatar, :content_type => /\Aimage\/(jpg|jpeg|png)\Z/

  def votes
    upvotes.count
  end

  private

  def generate_token
    self.token = Devise.friendly_token
  end
end
