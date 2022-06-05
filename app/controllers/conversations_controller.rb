class ConversationsController < ApplicationController
  before_action :set_conversation, except: [:index]
  before_action :check_participating!, except: [:index]

  def index
    @conversations = policy_scope(Conversation).participating(current_user).order('updated_at DESC')
  end

  def show
    @message = Message.new
    authorize @conversation
  end

  def new
    # redirect_to "/dashboard?conversation_id=#{@conversation.id}&page=conversations" and return if @conversation
    @message = current_user.messages.build
  end

  private

  def set_conversation
    if params[:offer_id]
      @offer = Offer.find(params[:offer_id])
      @conversation = Conversation.about(@offer.id)
    # if params[:receiver_id]
    #   @receiver = User.find(params[:receiver_id])
    #   # redirect_to "/dashboard?page=conversations" and return unless @receiver

    #   @conversation = Conversation.between(current_user.id, @receiver.id)[0]
    else
      @conversation = Conversation.find(params[:id])
      # redirect_to "/dashboard?page=conversations" and return unless @conversation&.participates?(current_user)
    end
  end

  def check_participating!
    redirect_to "/dashboard?page=conversations" unless @conversation&.participates?(current_user)
  end
end
