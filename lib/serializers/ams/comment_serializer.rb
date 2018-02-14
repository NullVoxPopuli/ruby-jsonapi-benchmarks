require_relative './post_serializer'

module AMS
  class CommentSerializer < ActiveModel::Serializer
    attributes :id,
               :author, :comment

    belongs_to :post, serializer: AMS::PostSerializer
  end
end
