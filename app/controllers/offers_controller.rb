class OffersController < ApplicationController
  before_action :set_offer
  skip_before_action :set_offer, only: :index
  skip_before_action :authenticate_user!, only: %i[index show]
  # geocode_by :address
  # after_validation :geocode # if longitude and latitude are NOT present

  def index
    if params[:query].present?
      @offers = policy_scope(Offer).global_search(params[:query])
      # Add .near(params[:city], km) once Geocoder is read for city-specific search
      # Check if we can use long or latitute
    else
      @offers = policy_scope(Offer)
    end
    # Markers for Map on Index page
    @markers = @offers.map do |offer|
      {
        lat: offer.latitude,
        lng: offer.longitude,
        info_window: render_to_string(partial: "info_window", locals: { offer: offer }),
        image_url: helpers.asset_url("map_marker")
      }
    end
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
