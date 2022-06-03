class DashboardController < ApplicationController

  def index
    @bookings = Booking.where(user: current_user)
    @conversations = Conversation.participating(current_user).order('updated_at DESC')
    @likes = current_user.likes # Like.where(user: current_user)
    # authorize all objects?
    @user = current_user
    @offers = policy_scope(Offer)
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
    authorize @user # ???
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
    params.require(:user).permit(:first_name, :last_name, :gender, :location, :date_of_birth)
  end

  def set_offer
    @offer = Offer.find(params[:id])
  end
end
