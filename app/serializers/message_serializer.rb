class MessageSerializer
  def initialize(message)
    @message = message
  end

  def json
    {
      name: @message.body
    }
  end
end
