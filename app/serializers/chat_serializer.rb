class ChatSerializer
  def initialize(chat)
    @chat = chat
  end

  def json
    {
      name: @chat.name,
      messages_count: @chat.messages_count,
      number: @chat.number
    }
  end
end
