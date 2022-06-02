class MessagesController < ApplicationController
  before_action :set_receiver
  before_action :find_conversation!

  def new
    @message = current_user.messages.build
  end

  def create
    @conversation ||= Conversation.create(author_id: current_user.id, receiver_id: @receiver.id)
    @message = current_user.messages.build(message_params)
    @message.conversation_id = @conversation.id
    @message.save!

    flash[:success] = "Your message was sent!"
    # might need to redirect somewhere else or not redirect anywhere
    redirect_to conversation_path(@conversation)
  end

  private

  def message_params
    params.require(:message).permit(:content)
  end

  def find_conversation!
    @conversation = Conversation.find(params[:conversation_id])
    redirect_to conversations_path and return unless @conversation&.participates?(current_user)
  end

  def set_receiver
    @offer = Offer.find(params[:id])
    @receiver = @offer.user
  end
end
