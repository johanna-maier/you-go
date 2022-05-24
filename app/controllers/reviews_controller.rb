class ReviewsController < ApplicationController
  def create
    @review = Review.new(review_params)
    @offer = Offer.find(params[:offer_id])
    @review.offer = @offer
    @review.user = current_user
    authorize @review

    respond_to do |format|
      if @review.save
        format.html { redirect_to offer_path(@offer) } # default response
        format.json # Follow the classic Rails flow and look for a create.json view
      else
        format.html { render "offers/show" }
        format.json # Follow the classic Rails flow and look for a create.json view
      end
    end
  end

  private

  def review_params
    params.require(:review).permit(:title, :comment, :rating)
  end
end
