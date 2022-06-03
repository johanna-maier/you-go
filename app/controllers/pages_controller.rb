class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: :home

  def home
    @offers = policy_scope(Offer)

    if current_user.present?
      recommender_url = "https://recommender-test-4ypjk67m2a-ew.a.run.app/recommender?user_id=#{current_user.id}"
      # Hard-coded results for Heroku user ID 59 by data team > Only ID that works for API for now.
      # No matter the user_id, always same result.
      begin
        response = URI.open(recommender_url).read
        data = JSON.parse(response)

        @recommended_offers = []

        data.first(4).each_with_index do |recommendation, index|
          # recommended_offer = Offer.find(recommendation)
          # Temporary till we can work with real user IDs + offers that are in DB
          recommended_offer = Offer.find(index + 2)
          @recommended_offers << recommended_offer
        end
      rescue OpenURI::HTTPError => e
        puts "Error message: #{e.message}"
        # Better way to recue API failures?
        @recommended_offers = Offer.first(4)
      end


    end

  end
end
