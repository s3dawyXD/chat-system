class MessagesController < ApplicationController
  before_action :set_message, only: %i[ show update destroy ]

  # GET /messages
  def index
    @messages = Message.joins(chat: :application)
    .where(applications: { id: params[:application_id] },
           chats: { number: params[:chat_id] })
    .order(created_at: :desc)
    if @messages.blank?
      render json: []
    else
      render json: MessageSerializer.new(@messages).json
    end
  end

  # GET /messages/1
  def show
    if @message.nil?
      render json: {message:"not found"}, status: :not_found
    else
    render json: MessageSerializer.new(@message).json
    end
  end

  # POST /messages
  def create
    @chat = Chat.where(application_id: params[:application_id], number: params[:chat_id]).last
    number = Redis.incr(@chat.id)
    @message = Message.new(body: params[:body], number: number, chat_id: @chat.id)
    stack_size = Redis.lpush('messages_data',{'number' => number,'body' => params[:body], 'chat_id' => @chat.id}.to_json)
    if stack_size >= 3
      data = Redis.rpop("messages_data",5)
      data = data.map { |messages_data| JSON.parse(messages_data)}
      Message.insert_all(data)
    end

    if @message.valid?
      render json: MessageSerializer.new(@message).json, status: :created
    else
      render json: @message.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /messages/1
  def update
    if @message.update(body: params[:body])
      render json: MessageSerializer.new(@message).json
    else
      render json: @message.errors, status: :unprocessable_entity
    end
  end

  # DELETE /messages/1
  def destroy
    @message.destroy!
  end

  def search
    Message.joins(chat: :application)
    .where(applications: { id: params[:application_id] },
           chats: { number: params[:chat_id] }).search(params[:q])
    render json: {message: "you are great"}
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_message
      @message = Message.joins(chat: :application)
      .where(applications: { id: params[:application_id] },
             chats: { number: params[:chat_id] },
             messages: { number: params[:id] })
      .order(created_at: :desc).lock
      .last
    end
end
