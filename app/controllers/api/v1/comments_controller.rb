module Api
  module V1
    class CommentsController < ApiController

      # Doc
      #   This action displays all the comments of a single post
      #
      # Params
      #   post_id: integer (identifier of the post the comments belong to)
      #
      def index
        post = Post.find(params[:post_id])
        expose post.comments.paginate(page: params[:page], per_page: PER_PAGE_NUMBER), each_serializer: CommentSerializer
      end

      # Doc
      #   This action creates a new comment
      #
      # Params
      #   post_id: integer (identifier of the post the comment will belong to)
      #
      def create
        post = Post.find(params[:post_id])
        comment = post.comments.new(comment_params)
        comment.author_name = @user.nickname
        comment.save
        expose comment, serializer: CommentSerializer
      end

      # Doc
      #   This action destroys a single comment
      #
      # Params
      #   id: integer (comment's identifier)
      #
      def destroy
        comment = Comment.find(params[:id])
        error! :not_found if comment.blank?
        comment.destroy
        expose status: :no_content
      end

      private

      def comment_params
        params.require(:comment).permit(:content)
      end
    end
  end
end
