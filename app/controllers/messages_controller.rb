class MessagesController < ApplicationController
  before_action :find_conversation!

  def new
    @message = current_user.messages.build
  end

  def create
    @conversation ||= Conversation.create(author_id: current_user.id, receiver_id: receiver_id, offer_id: offer_id)
    @message = current_user.messages.build(message_params)
    @message.conversation_id = @conversation.id
    @message.save!
    authorize @message

    flash[:success] = "Your message was sent!"
    redirect_to "/dashboard?conversation_id=#{@conversation.id}&page=conversations"
  end

  private

  def receiver_id
    params[:receiver_id]
  end

  def offer_id
    params[:offer_id]
  end

  def message_params
    params.require(:message).permit(:content)
  end

  def find_conversation!
    @conversation = Conversation.find(params[:conversation_id]) unless params[:conversation_id].empty?
  end
end
