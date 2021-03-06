require_relative './post_serializer'

module AMS
  class UserSerializer < ActiveModel::Serializer
    attributes :id,
               :first_name, :last_name, :birthday,
               :created_at, :updated_at

    has_many :posts, each_serializer: AMS::PostSerializer
  end
end
