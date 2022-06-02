class ConversationsController < ApplicationController
  before_action :set_conversation, except: [:index]
  before_action :check_participating!, except: [:index]

  def index
    @conversations = Conversation.participating(current_user).order('updated_at DESC')
  end

  def show
    @message = Message.new
  end

  def new
    redirect_to conversation_path(@conversation) and return if @conversation

    @message = current_user.messages.build
  end

  private

  def set_conversation
    if params[:receiver_id]
      @receiver = User.find(params[:receiver_id])
      redirect_to conversations_path and return unless @receiver

      @conversation = Conversation.between(current_user, @receiver.id)[0]
    else
      @conversation = Conversation.find(params[:conversation_id])
      redirect_to conversations_path and return unless @conversation&.participates?(current_user)
    end
  end

  def check_participating!
    redirect_to conversations_path unless @conversation&.participates?(current_user)
  end
end
