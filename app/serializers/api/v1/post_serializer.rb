module Api
  module V1
    class PostSerializer < ActiveModel::Serializer

      attributes :id, :title, :content, :comments_count, :upvotes_count

      has_one :user, serializer: UserSerializer

    end
  end
end
