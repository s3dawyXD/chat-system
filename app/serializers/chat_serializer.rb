class ChatSerializer
  def initialize(chat)
    @chat = chat
  end

  def json
    if @chat.respond_to?('map')
      result = @chat.map { |obj| {
        name: obj.name,
        messages_count: obj.messages_count,
        number: obj.number
      } }
    else
      result = {
        name: @chat.name,
        messages_count: @chat.messages_count,
        number: @chat.number
      }
    end
    return result
  end
end
