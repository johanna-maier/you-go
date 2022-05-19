class OffersController < ApplicationController
  before_action :set_offer
  skip_before_action :set_offer, only: :index
  skip_before_action :authenticate_user!, only: %i[index show]

  def index
    @offers = policy_scope(Offer)
  end

  def show
    @review = Review.new # need this for the review form on same page
    authorize @offer
    @user = current_user
    # Add tracking for viewing an offers showpage
    # ahoy.track "View Offer Page ID #{@offer.id}", user: @user.id, offer: @offer.id
  end

  private

  def offer_params
    params.require(:offer).permit(:title, :description, :price_per_person, :capacity, :address,
                                  :longitude, :latitude, :is_external, :url, :offer_date, :offer_time,
                                  photos: [])
  end

  def set_offer
    @offer = Offer.find(params[:id])
  end
end
