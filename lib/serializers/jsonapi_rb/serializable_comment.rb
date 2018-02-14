module JsonapiRb
  class SerializableComment < JSONAPI::Serializable::Resource
    type 'comments'

    attributes :author, :comment

    if ENV['USE_DEFAULTS']
      belongs_to :post
    else
      belongs_to :post do
        linkage(always: true)
      end
    end
  end
end
