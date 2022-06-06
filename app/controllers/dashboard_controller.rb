class DashboardController < ApplicationController

  def index
    @bookings = Booking.where(user: current_user)
    @likes = current_user.likes
    @booking = Booking.new # for new booking on wishlist screen
    # for conversations
    @conversations = Conversation.participating(current_user).order('updated_at DESC')
    @message = Message.new
    if params[:conversation_id]
      @conversation = Conversation.find(params[:conversation_id])
    else
      @conversation = @conversations.first
    end


    @messages = @conversation.messages.reorder('messages.created_at ASC')

    # authorize all objects?
    #  for profile screen
    @user = current_user
    @offers = policy_scope(Offer)

    # wishlist screen
    if params[:offer_id]
      @offer = Offer.find(params[:offer_id])
    else
      @offer = @likes.first.offer unless @likes.empty?
    end

    if params[:page]
      @page = params[:page]
    else
      @page = 'profile'
    end
  end

  def update
    @user = current_user
    authorize @user
    if @user.update(user_params)
      redirect_to dashboard_index_path, notice: 'Your profile was successfully updated.'
    else
      render 'profile'
    end
  end

  def details
    set_offer
    authorize @offer
  end

  private

  def user_params
    # ["21, 22, 23"] => ["21", "22", "23"]
    params[:user][:preferences] = params[:user][:preferences][0].split(",")
    # puts params[:user][:preferences]
    params.require(:user).permit(:first_name, :last_name, :gender, :location, :date_of_birth, preferences: [])
  end

  def set_offer
    @offer = Offer.find(params[:id])
  end
end
