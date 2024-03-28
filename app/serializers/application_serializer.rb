class ApplicationSerializer
  # include FastJsonapi::ObjectSerializer
  # # include JSONAPI::Serializer
  # attributes :id, :name
  # attribute :id, key: :token
  def initialize(application)
    @application = application
  end

  def json
    {
      token: @application.id,
      name: @application.name,
      chats_count: @application.chats_count
    }
  end
end
