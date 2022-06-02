class OffersController < ApplicationController
  before_action :set_offer
  skip_before_action :set_offer, only: :index
  skip_before_action :authenticate_user!, only: %i[index show]
  # geocode_by :address
  # after_validation :geocode # if longitude and latitude are NOT present

  def index
    @offers = policy_scope(Offer).reorder("offers.offer_date ASC")
    if params[:city].present? && params[:query].present?
      @offers = policy_scope(Offer).near(params[:city], 80, min_radius: 10).global_search(params[:query]).reorder("offers.offer_date ASC")
    else
      @offers = policy_scope(Offer).near(params[:city], 80, min_radius: 10).reorder("offers.offer_date ASC") if params[:city].present?
      @offers = policy_scope(Offer).global_search(params[:query]).reorder("offers.offer_date ASC") if params[:query].present?
    end

    if params[:category].present?
      @offers = policy_scope(Offer).category_search(params[:category]).reorder("offers.offer_date ASC")
    end

    @offers_with_coordinates = @offers.where.not(latitude: nil).and(@offers.where.not(longitude: nil))
    # Markers for Map on Index page
    @markers = @offers_with_coordinates.map do |offer|
      {
        lat: offer.latitude,
        lng: offer.longitude,
        info_window: render_to_string(partial: "info_window", locals: { offer: offer }),
        image_url: helpers.asset_url("map_marker.png")
      }
    end

  end

  def show
    @review = Review.new # need this for the review form on same page
    @booking = Booking.new
    authorize @offer
    @user = current_user

    # Add tracking for viewing an offers showpage only if user is logged in
    if current_user
      ahoy.track "View Offer Page ID #{@offer.id}", user: @user.id, offer: @offer.id

    end



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
