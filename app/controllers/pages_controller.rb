class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: :home

  def home
    @offers_in_future = policy_scope(Offer).where('offer_date > ?', DateTime.now)
    @offers_today_tomorrow = policy_scope(Offer).where(offer_date: Date.today..1.day.from_now)

    @categories_with_offers = Tag.where("name = category").select { |x| x.offers.count > 1 }

    # Make sure that a user is logged in before trying to access the API
    if current_user.present?
      # If Maria is logged in, she gets her results. For all other loggedin users, Daniels results are displayed.
      if current_user.id == 66
        recommender_url = "https://recommender-test-4ypjk67m2a-ew.a.run.app/recommender?user_id=66"
      else
        recommender_url = "https://recommender-test-4ypjk67m2a-ew.a.run.app/recommender?user_id=70"
      end

      begin
        response = URI.open(recommender_url).read
        data = JSON.parse(response)

        @recommended_offers = []
        # get first 3 API entries
        data.first(3).each_with_index do |recommendation_id, index|
          # Check if offer IDs actually exist in DB
          if Offer.where(id: recommendation_id).present?
            recommended_offer = Offer.find(recommendation_id)
            @recommended_offers << recommended_offer
          else
            # If offerr ID is not present, add first (second, third, ...) offer as recommendation.
            first_offer_id = Offer.first.id
            @recommended_offers << Offer.find(first_offer_id + index)
          end
        end
      rescue OpenURI::HTTPError => e
        # If API fails, we just give back the first 3 offers in DB as recommendations.
        @recommended_offers = Offer.first(3)
      end
    end

  end
end
