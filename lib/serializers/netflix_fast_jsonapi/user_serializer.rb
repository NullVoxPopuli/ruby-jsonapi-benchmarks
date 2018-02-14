module NetflixFastJsonapi
  class UserSerializer
    include FastJsonapi::ObjectSerializer

    set_type :users

    attributes :first_name, :last_name, :birthday,
               :created_at, :updated_at

    has_many :posts
  end
end
