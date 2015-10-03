module Api
  module V1
    class SubredditsController < ApiController

      # Doc
      #   Action listing all the subreddits while paginating them
      #
      def index
        expose Subreddit.paginate(page: params[:page], per_page: PER_PAGE_NUMBER), each_serializer: SubredditSerializer
      end

      # Doc
      #   This action displays a single subreddit
      #
      # Params
      #   id: integer (subreddit's identifier)
      #
      def show
        subreddit = Subreddit.find(params[:id])
        error! :not_found if subreddit.blank?
        expose subreddit, serializer: SubredditSerializer
      end

      # Doc
      #   This action creates a new subreddit
      #
      def create
        expose Subreddit.create(subreddit_params), serializer: SubredditSerializer
      end

      # Doc
      #   This action updates a subreddit's name and/or description
      #
      # Params
      #   id: integer (subreddit's identifier)
      #
      def update
        subreddit = Subreddit.find(params[:id])
        error! :not_found if subreddit.blank?
        subreddit.update(subreddit_params)
        expose subreddit, serializer: SubredditSerializer
      end

      # Doc
      #   This action destroys a subreddit
      #
      # Params
      #   id: integer (subreddit's identifier)
      #
      def destroy
        subreddit = Subreddit.find(params[:id])
        error! :not_found if subreddit.blank?
        subreddit.destroy
        expose status: :no_content
      end

      private

      def subreddit_params
        params.require(:subreddit).permit(:name, :description)
      end
    end
  end
end
