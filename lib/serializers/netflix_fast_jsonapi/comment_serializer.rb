module NetflixFastJsonapi
  class CommentSerializer
    include FastJsonapi::ObjectSerializer

    set_type :comments

    attributes :author, :comment

    belongs_to :post
  end
end
