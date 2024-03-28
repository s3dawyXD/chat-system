class ChatsController < ApplicationController
  before_action :set_chat, only: %i[ show update destroy ]

  # GET /chats/1
  def show
    render json: ChatSerializer.new(@chat).json
  end

  # POST /chats
  def create
    @application = Application.find(params[:application_id])
    @chat = @application.chats.create(name: params[:name])
    # render json: @application
    if @chat.save
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
      @chat = Chat.where(application_id: params[:application_id],id: params[:id]).last
    end

    # Only allow a list of trusted parameters through.
    # def chat_params
    #   params.require(:chat).permit!
    # end
end
