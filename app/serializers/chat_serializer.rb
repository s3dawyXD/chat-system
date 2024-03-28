class ChatSerializer
  def initialize(chat)
    @chat = chat
  end

  def json
    {
      id: @chat.id,
      name: @chat.name
    }
  end
end
