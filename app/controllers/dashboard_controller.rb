class DashboardController < ApplicationController

  def index
    # @bookings = Booking.where(user: current_user)
    # @offers = Offer.where(user: current_user)
    # @likes = Like.where(user: current_user)
    # authorize all objects?
    @user = current_user
    @offers = policy_scope(Offer)
  end

  def update
  end
end
