require_relative './models/application_record'
require_relative './models/comment'
require_relative './models/post'
require_relative './models/user'

require_relative './serializers/ams/comment_serializer'
require_relative './serializers/ams/post_serializer'
require_relative './serializers/ams/user_serializer'

require_relative './serializers/jsonapi_rb/serializable_comment'
require_relative './serializers/jsonapi_rb/serializable_post'
require_relative './serializers/jsonapi_rb/serializable_user'

require_relative './serializers/netflix_fast_jsonapi/comment_serializer'
require_relative './serializers/netflix_fast_jsonapi/post_serializer'
require_relative './serializers/netflix_fast_jsonapi/user_serializer'
