module Api
  module V1
    class PostsController < ApiController

      # Doc
      #   This action displays all the posts of a single subreddit
      #
      # Params
      #   subreddit_id: integer (identifier of a subreddit the posts belong to)
      #
      def index
        subreddit = Subreddit.find(params[:subreddit_id])
        expose subreddit.posts.paginate(page: params[:page], per_page: PER_PAGE_NUMBER), each_serializer: PostSerializer
      end

      # Doc
      #   This action displays a single post
      #
      # Params
      #   id: integer (post's identifier)
      #
      def show
        post = Post.find(params[:id])
        error! :not_found if post.blank?
        expose post, serializer: PostSerializer
      end

      # Doc
      #   This action creates a new post
      #
      # Params
      #   subreddit_id: integer (identifier of a subreddit the new post will belong to)
      #
      def create
        subreddit = Subreddit.find(params[:subreddit_id])
        post = subreddit.posts.new(post_params)
        post.creator_name = @user.nickname
        post.user_id = @user.id
        post.save
        expose post, serializer: PostSerializer
      end

      # Doc
      #   This action updates a single post's title and/or content
      #
      # Params
      #   id: integer (post's identifier)
      #
      def update
        post = Post.find(params[:id])
        error! :not_found if post.blank?
        post.update(post_params)
        expose post, serializer: PostSerializer
      end

      # Doc
      #   This action destroys a single post
      #
      # Params
      #   id: integer (post's identifier)
      #
      def destroy
        post = Post.find(params[:id])
        error! :not_found if post.blank?
        post.destroy
        expose status: :no_content
      end

      # Doc
      #   This action upvotes a single post by current user
      #
      # Params
      #   post_id: integer (post's identifier)
      #
      def upvote
        post = Post.find(params[:post_id])
        error! :not_found if post.blank?
        post.upvote(@user)
        expose post, serializer: PostSerializer
      end

      private

      def post_params
        params.require(:post).permit(:title, :content)
      end
    end
  end
end
