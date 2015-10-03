class StaticPagesController < ApplicationController

  def index
    @posts = Post.where(subreddit_id: @subreddits.map(&:id)).paginate(page: params[:page], per_page: PER_PAGE_NUMBER).newest
    @title = 'Frontpage'
    @name = 'frontpage'
    @disabled = true
    @frontpage = true
  end

  def upvote
    @post = Post.find(params[:post_id])
    unless @post.user === current_user
      @post.upvote(current_user)
    end

    #calling index action to get all the needed variables
    index

    respond_to do |format|
      format.html { render :index }
      format.js   {}
      format.json { render json: @subreddits.to_json }
    end
  end
end
