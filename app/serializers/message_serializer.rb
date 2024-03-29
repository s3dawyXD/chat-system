class MessageSerializer
  def initialize(message)
    @message = message
  end

  def json
    if @message.respond_to?('map')
      result = @message.map { |obj| {
        body: obj.body,
        number: obj.number
      } }
    else
      result = {
        body: @message.body,
        number: @message.number
      }
    end
    return result
  end
end
