class DashboardController < ApplicationController

  def index
    # @bookings = Booking.where(user: current_user)
    # @offers = Offer.where(user: current_user)
    # @likes = Like.where(user: current_user)
    @bookings = Booking.where(user: current_user)
    # @offers = Offer.where(user: current_user)
    @likes = current_user.likes   # Like.where(user: current_user)

    # authorize all objects?
    @user = current_user
    @offers = policy_scope(Offer)
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

  private

  def user_params
    params.require(:user).permit(:first_name, :last_name, :gender, :location, :date_of_birth)
  end
end
