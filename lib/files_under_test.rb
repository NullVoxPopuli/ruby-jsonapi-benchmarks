require_relative './models/application_record'
require_relative './models/comment'
require_relative './models/post'
require_relative './models/user'

# Pre-define things, cause circular references (Rails' autoloader handles this for us, typically)
module AMS
  class UserSerializer < ActiveModel::Serializer; end
  class PostSerializer < ActiveModel::Serializer; end
  class CommentSerializer < ActiveModel::Serializer; end
end


Dir[File.dirname(__FILE__) + '/serializers/ams/*.rb'].each {|file| require file }
Dir[File.dirname(__FILE__) + '/serializers/jsonapi_rb/*.rb'].each {|file| require file }
Dir[File.dirname(__FILE__) + '/serializers/netflix_fast_jsonapi/*.rb'].each {|file| require file }
