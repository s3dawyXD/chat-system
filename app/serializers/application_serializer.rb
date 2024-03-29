class ApplicationSerializer
  # include FastJsonapi::ObjectSerializer
  # # include JSONAPI::Serializer
  # attributes :id, :name
  # attribute :id, key: :token
  def initialize(application)
    @application = application
  end

  def json
    if @application.respond_to?('map')
      result = @application.map { |obj| {
        token: obj.id,
        name: obj.name,
        chats_count: obj.chats_count
      } }
    else
      result = {
        token: @application.id,
        name: @application.name,
        chats_count: @application.chats_count
      }
    end

    return result

  end


end
