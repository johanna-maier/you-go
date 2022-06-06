class BookingsController < ApplicationController
  before_action :set_offer

  def create
    @booking = Booking.new(booking_params)
    @booking.offer = @offer
    @booking.user = current_user
    authorize @booking
    if @booking.save!
      # redirect_to @offer, notice: 'Offer was successfully booked.'
      # redirect to dashboard after booking
      redirect_to dashboard_index_path(offer_id: @booking.offer_id, page: 'bookings'), notice: 'Offer was successfully booked.'
    else
      render :new
    end
  end

  def destroy
  end

  private

  def booking_params
    params.require(:booking).permit(:number_of_participants, :message)
  end

  def set_offer
    @offer = Offer.find(params[:offer_id])
  end
end
