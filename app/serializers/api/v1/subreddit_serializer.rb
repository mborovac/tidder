module Api
  module V1
    class SubredditSerializer < ActiveModel::Serializer

      attributes :id, :name, :description, :excerpt

      has_many :recent_posts, serializer: PostSerializer

      def excerpt
        object.description.truncate(140)
      end

      def recent_posts
        object.posts.newest.limit(10)
      end

    end
  end
end
