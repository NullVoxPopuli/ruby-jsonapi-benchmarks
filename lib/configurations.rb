
ActiveModelSerializers.config.adapter = :json_api

unless ENV['USE_DEFAULTS']
  ActiveModelSerializers.config.key_transform = :unaltered # default is dash
end

# AMS struggles with serializer lookup...
# NOTE: by default, there are 4 lookup procs
# https://github.com/rails-api/active_model_serializers/blob/0-10-stable/docs/general/configuration_options.md#serializer_lookup_chain
ActiveModelSerializers.config.serializer_lookup_chain = [
  lambda do |resource_class, serializer_class, namespace|
    "AMS::#{resource_class}Serializer"
  end
]
# Kill AMS stdout logging...
ActiveSupport::Notifications.unsubscribe(ActiveModelSerializers::Logging::RENDER_EVENT)

