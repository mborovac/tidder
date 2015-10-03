module Api
  module V1
    class UserSerializer < ActiveModel::Serializer

      attributes :id, :email, :nickname, :gender, :upvotes_count, :subreddit_ids

      def gender
        object.gender
      end

      def upvotes_count
        object.votes
      end

    end
  end
end
