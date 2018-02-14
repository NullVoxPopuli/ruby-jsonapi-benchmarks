require_relative './user_serializer'
require_relative './comment_serializer'

module AMS
  class PostSerializer < ActiveModel::Serializer
    attributes :id,
               :title, :body,
               :created_at, :updated_at

    belongs_to :user, serializer: AMS::UserSerializer
    has_many :comments, each_serializer: AMS::CommentSerializer
  end
end
