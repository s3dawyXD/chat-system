class ChatsController < ApplicationController
  before_action :set_chat, only: %i[ show update destroy ]

  def index
    @chats = Chat.where(application_id: params[:application_id])
    if @chats.blank?
      render json: []
    else
      render json: ChatSerializer.new(@chats).json
    end
  end

  # GET /chats/1
  def show
    if @chat.nil?
      render json: {message:"not found"}, status: :not_found
    else
      render json: ChatSerializer.new(@chat).json
    end
  end

  # POST /chats
  def create
    number = Redis.incr(params[:application_id])
    @chat = Chat.new(name: params[:name], number: number, application_id: params[:application_id])
    stack_size = Redis.lpush('chats_data',{'number' => number, 'name' => params[:name], 'application_id' => params[:application_id]}.to_json)
    if stack_size >= 3
      data = Redis.rpop("chats_data",5)
      data = data.map { |chat_data| JSON.parse(chat_data)}
      Chat.insert_all(data)
    end
    if @chat.valid?
      render json: ChatSerializer.new(@chat).json, status: :created
    else
      render json: @chat.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /chats/1
  def update
    if @chat.update(name: params[:name])
      render json: ChatSerializer.new(@chat).json
    else
      render json: @chat.errors, status: :unprocessable_entity
    end
  end

  # DELETE /chats/1
  def destroy
    @chat.destroy!
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_chat
      @chat = Chat.where(application_id: params[:application_id],number: params[:id]).lock!.last
    end

    # Only allow a list of trusted parameters through.
    # def chat_params
    #   params.require(:chat).permit!
    # end
end
