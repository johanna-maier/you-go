class MessagesController < ApplicationController
  before_action :set_receiver
  before_action :find_conversation!

  def new
    @message = current_user.messages.build
    authorize @message
  end

  # For Testing the offer is simply set to 562. That last bit will need to be removed afterwards!!!
  def create
    @conversation ||= Conversation.create(author_id: current_user.id, receiver_id: @receiver.id, offer_id: 562)
    @message = current_user.messages.build(message_params)
    @message.conversation_id = @conversation.id
    @message.save!
    authorize @message

    flash[:success] = "Your message was sent!"
    # Might need to redirect somewhere else or not redirect anywhere
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
    # For Testing just set to one user: DANIEL
    @receiver = User.find(32)
    # After connecting to Offers, the code below will replace the preset above and will need to be TESTED!!!
    # @offer = Offer.find(params[:id])
    # @receiver = @offer.user
  end
end
