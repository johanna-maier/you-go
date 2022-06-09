class OffersController < ApplicationController
  before_action :set_offer
  skip_before_action :set_offer, only: :index
  skip_before_action :authenticate_user!, only: %i[index show]
  # geocode_by :address
  # after_validation :geocode # if longitude and latitude are NOT present

  def index
    @offers_in_future = policy_scope(Offer).where('offer_date > ?', DateTime.now)
    # If we want to filter only by tags which are not categories as well add: .where.not("name = category")
    @tags_with_offers = Tag.select { |x| x.offers.count > 1 }

    if params[:city].present? && params[:query].present?
      @offers = @offers_in_future.near(params[:city], 50).global_search(params[:query]).reorder("offers.offer_date ASC")
    elsif params[:city].present?
      @offers = @offers_in_future.near(params[:city], 50).reorder("offers.offer_date ASC")
    elsif params[:query].present?
      @offers = @offers_in_future.global_search(params[:query]).reorder("offers.offer_date ASC")
    elsif params[:category].present?
      # .near added here so that offers are scoped to Europe
      @offers = @offers_in_future.category_search(params[:category]).near([51.165691, 10.451526], 2000).reorder("offers.offer_date ASC")
    else
      # .near added here so that offers are scoped to Europe
      @offers = @offers_in_future.near([51.165691, 10.451526], 2000, min_radius: 1).reorder("offers.offer_date ASC")
    end

    if @offers.empty?
      # Markers for Map on Index page
      @markers = @offers.map do |offer|
        {
          lat: offer.latitude,
          lng: offer.longitude,
          info_window: render_to_string(partial: "info_window", locals: { offer: offer }),
          image_url: helpers.asset_url("map_marker.png")
        }
      end
    else
      # Throws errors when @offers.empty? > If statement to avoid this case.
      @offers_with_coordinates = @offers.where.not(latitude: nil).or(@offers.where.not(longitude: nil))
      # Europe scope added above where necessary.
      # @offers_in_europe = @offers_with_coordinates.near([51.165691, 10.451526], 2000, min_radius: 1)
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
  end

  def show
    @review = Review.new # need this for the review form on same page
    @booking = Booking.new
    @conversation = Conversation.new
    @message = Message.new
    @user = current_user
    authorize @offer
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
