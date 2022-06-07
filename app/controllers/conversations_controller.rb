class ConversationsController < ApplicationController
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
end
