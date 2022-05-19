class ReviewsController < ApplicationController
  def create
    @review = Review.new(review_params)
    @offer = Offer.find(params[:offer_id])
    @review.offer = @offer
    @review.user = current_user
    authorize @review
    if @review.save
      redirect_to offer_path(@offer)
    else
      render 'offers/show'
    end

  end

  private

  def review_params
    params.require(:review).permit(:title, :comment, :rating)
  end
end
