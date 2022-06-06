class DashboardController < ApplicationController
  def index
    @user = current_user
    @offers = policy_scope(Offer)
    set_conversation
    set_booking
    set_offer_for_wishlist
    set_page
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

  def set_conversation
    @conversations = Conversation.participating(current_user).order('updated_at DESC')
    @message = Message.new
    if params[:conversation_id]
      @conversation = Conversation.find(params[:conversation_id])
    else
      @conversation = @conversations.first
    end
  end

  def set_booking
    @booking = Booking.new
    @bookings = Booking.where(user: current_user)
  end

  def set_offer_for_wishlist
    @likes = current_user.likes
    if params[:offer_id]
      @offer = Offer.find(params[:offer_id])
    else
      @offer = @likes.first.offer unless @likes.empty?
    end
  end

  def set_page
    if params[:page]
      @page = params[:page]
    else
      @page = 'profile'
    end
  end

  def user_params
    # ["21, 22, 23"] => ["21", "22", "23"]
    params[:user][:preferences] = params[:user][:preferences][0].split(",")
    # params[:user][:preferences]
    params.require(:user).permit(:first_name, :last_name, :gender, :location, :date_of_birth, preferences: [])
  end

  def set_offer
    @offer = Offer.find(params[:id])
  end
end
