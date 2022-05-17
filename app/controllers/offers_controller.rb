class OffersController < ApplicationController
  before_action :set_offer
  skip_before_action :set_offer, only: :index
  skip_before_action :authenticate_user!, only: %i[index show]

  def index
    @offers = policy_scope(Offer)
  end

  def show
    authorize @offer
  end

  private

  # def offer_params
  #   params.require(:offer).permit(...)
  # end

  def set_offer
    @offer = Offer.find(params[:id])
  end
end
