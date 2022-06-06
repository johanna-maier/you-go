class ConversationsController < ApplicationController
  before_action :set_conversation, except: [:index]

  def index
    @conversations = policy_scope(Conversation).participating(current_user).order('updated_at DESC')
  end

  def show
    @message = Message.new
    authorize @conversation
  end

  def new
    @message = current_user.messages.build
  end

  private

  def set_conversation
    if params[:offer_id]
      @offer = Offer.find(params[:offer_id])
      @conversation = Conversation.about(@offer.id)
    else
      @conversation = Conversation.find(params[:id])
    end
  end
end
