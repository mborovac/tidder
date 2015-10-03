class SubredditsController < ApplicationController

  before_action :init_variables

  def index
    @all_subreddits = Subreddit.paginate(page: params[:page], per_page: PER_PAGE_NUMBER)
    @name = 'All subreddits'
    @disabled = true
    @frontpage = true
  end

  def newest
    @all_subreddits = Subreddit.paginate(page: params[:page], per_page: PER_PAGE_NUMBER).newest
    @name = 'Newest subreddits'
    @disabled = true
    @frontpage = true
  end

  def trending
    @all_subreddits = Subreddit.trending
    @name = 'Trending subreddits'
    @disabled = true
    @frontpage = true
  end

  def show
    @subreddit = Subreddit.find(params[:id])
    @posts = @subreddit.posts.all.paginate(page: params[:page], per_page: PER_PAGE_NUMBER).newest
    @name = @subreddit.name
    @title = 'Subreddit'
  end

  def new
    @subreddit = Subreddit.new
    @name = 'New subreddit'
    @frontpage = true
    @disabled = true
    @newsubreddit = true
  end

  def create
    @subreddit = Subreddit.new(subreddit_params)

    if @subreddit.save
      SubredditSubscription.create(user_id: current_user.id, subreddit_id: @subreddit.id)
      params[:id] = @subreddit.id
      subscription
      redirect_to subreddit_path(id: @subreddit.id)
    else
      @name = 'New subreddit'
      @frontpage = true
      @disabled = true
      @newsubreddit = true
      render :new
    end
  end

  def subscribe
    subscription
    respond_to_subscription
  end

  def unsubscribe
    SubredditSubscription.where(user_id: current_user.id, subreddit_id: params[:id]).destroy_all
    respond_to_subscription
  end

  def upvote
    @subreddit = Subreddit.find(params[:id])
    @post = Post.find(params[:post_id])
    @post.upvote(current_user)

    #calling show action to get all the needed variables
    show

    respond_to do |format|
      format.html { render :show }
      format.js   {}
      format.json { render json: @subreddits.to_json }
    end
  end

  private

  def init_variables
    @subscribed = SubredditSubscription.exists?(user_id: current_user.id, subreddit_id: params[:id])
  end

  def subreddit_params
    params.require(:subreddit).permit(:name, :description)
  end

  def subscription
    subscription = SubredditSubscription.find_or_create_by(user_id: current_user.id, subreddit_id: params[:id])
    unless subscription.save
      flash[:alert] = "Cannot subscribe!"
    end
  end

  def respond_to_subscription
    @subreddit = Subreddit.find(params[:id])
    respond_to do |format|
      format.html { render :show }
      format.js   {}
      format.json { render json: @subreddits.to_json }
    end
  end
end
