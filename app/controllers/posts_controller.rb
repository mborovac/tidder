class PostsController < ApplicationController

  before_action :init_variables

  def show
    @post = Post.find(params[:id])
    @name = @subreddit.name
    @title = 'Single Post'
    @comment = Comment.new
    @comments = @post.comments.newest
  end

  def new
    @post = Post.new
    @name = 'New post'
    @newpost = true
  end

  def create
    @subreddit = Subreddit.find(params[:subreddit_id])
    @post = @subreddit.posts.new(post_params)
    @post.user_id = current_user.id
    if @post.save
      redirect_to subreddit_post_path(@subreddit.id, @post.id)
    else
      render :new
    end
  end

  def edit
    @post = Post.find(params[:id])
    @name = "Edit post"
    @newpost = true
  end

  def update
    @post = Post.find(params[:id])
    if @post.update(post_params)
      redirect_to subreddit_post_path
    else
      render :edit
    end
  end

  def destroy
    Post.find(params[:id]).destroy
    redirect_to subreddit_path(params[:subreddit_id])
  end

  def newest
    @posts = Post.all.paginate(page: params[:page], per_page: PER_PAGE_NUMBER).newest
    @disabled = true
    @frontpage = true
  end

  def trending
    @all_subreddits = Post.trending
    @disabled = true
    @frontpage = true
  end

  private

  def init_variables
    @subreddit = Subreddit.find(params[:subreddit_id])
    @subscribed = SubredditSubscription.exists?(user_id: current_user.id, subreddit_id: params[:subreddit_id])
  end

  def post_params
    params.require(:post).permit(:title, :content)
  end
end
