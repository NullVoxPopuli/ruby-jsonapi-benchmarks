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

  def fast_jsonapi(data)
    NetflixFastJsonapi::UserSerializer.new(data, include: [:posts]).serializable_hash
  end
end
