module JsonapiRb
  class SerializableUser < JSONAPI::Serializable::Resource
    type 'users'

    attributes :first_name, :last_name, :birthday,
               :created_at, :updated_at

    if ENV['USE_DEFAULTS']
      has_many :posts
    else
      has_many :posts do
        linkage(always: true)
      end
    end
  end
end
