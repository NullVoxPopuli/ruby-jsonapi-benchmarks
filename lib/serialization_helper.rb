# freaking AMS.
Dir[File.dirname(__FILE__) + '/serializers/ams/*.rb'].each {|file| require file }

module SerializationHelper
  module_function

  def test_render(render_with)
    render_data(
      User.first,
      render_with
    )
  end

  def test_manual_eagerload(render_with)
    render_data(
      # User.auto_include(false).includes(posts: [:comments]).first,
      User.includes(posts: [:comments]).first,
      render_with
    )
  end

  def render_data(data, render_with)
    send(render_with, data)
  end

  def ams(data)
    ActiveModelSerializers::SerializableResource.new(
      data,
      include: 'posts',
      # fields: params[:fields],
      adapter: :json_api,
      serializer: AMS::UserSerializer
    ).as_json
  end

  def jsonapi_rb(data)
    JSONAPI::Serializable::Renderer.new.render(
      data,
      include: 'posts',
      class: {
        User: JsonapiRb::SerializableUser,
        Post: JsonapiRb::SerializablePost,
        Comment: JsonapiRb::SerializableComment
      }
    )
  end

  # NOTE: at the time of writing this, netflix doesn't support:
  # -  nested includes.......
  # - relationship types aren't the same as the resource type...
  # - _not_ rendering every id in a has_many relationship...
  #   by default, this means that jsonapi-rb is a clear winner...
  def fast_jsonapi(data)
    NetflixFastJsonapi::UserSerializer.new(data, include: [:posts]).serializable_hash
  end
end
