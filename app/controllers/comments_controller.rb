class CommentsController < ApplicationController

  before_action :init_variables

  def create
    post = Post.find(params[:post_id])
    @comment = post.comments.new(comment_params)
    @comment.user_id = current_user.id
    @comment.save
    send_notification
    redirect_to subreddit_post_path(@subreddit, @post)
  end

  private

  def init_variables
    @subreddit = Subreddit.find(params[:subreddit_id])
    @post = @subreddit.posts.find(params[:post_id])
    @subscribed = SubredditSubscription.exists?(user_id: current_user.id, subreddit_id: params[:subreddit_id])
  end

  def comment_params
    params.require(:comment).permit(:content, :post_id)
  end

  def send_notification
    @user = User.find(@post.user_id)
    Notifications.comments(@user, @post, @comment).deliver_now
  end

end
