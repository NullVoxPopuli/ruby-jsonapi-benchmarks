module JsonapiRb
  class SerializablePost < JSONAPI::Serializable::Resource
    type 'posts'

    attributes :title, :body,
               :created_at, :updated_at

    if ENV['USE_DEFAULTS']
      belongs_to :user
      has_many :comments
    else
      belongs_to :user do
        linkage(always: true)
      end

      has_many :comments do
        linkage(always: true)
      end
    end
  end
end
