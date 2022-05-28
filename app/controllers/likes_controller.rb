class LikesController < ApplicationController
  def create
    @offer = Offer.find(params[:offer_id])
    if @offer.user_id.nil? || @offer.user_id != current_user.id # You can register favorites other than your own offer

      # check if 'like' with user id and offer id already exists in the database
      # if it does not exist, we will create it. if it exists we will update it (delete it)
      @like = Like.new(user_id: current_user.id, offer_id: @offer.id)
      authorize @like

      respond_to do |format|
        if @like.save
          # puts "record created!"
          format.json # Follow the classic Rails flow and look for a create.json view
        else
          # puts "record creation failed!"
          format.json # Follow the classic Rails flow and look for a create.json view
        end
      end
    end
  end

  def destroy
    @offer = Offer.find(params[:offer_id])
    @like = Like.find(params[:id])
    # puts "---------- @offer_id = #{@offer.id}   @like_id = #{@like.id}  current_user = #{current_user.id}"
    authorize @like

    respond_to do |format|
      if @like.destroy
        # puts "record destroyed successfuly!"
        format.json # look for a destroy.json view
      else
        # puts "record destroyed failed"
        format.json # look for a destroy.json view
      end
    end
  end
end
