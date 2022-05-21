if @review.persisted?
  # new blank form
  json.form   json.partial!("reviews/form_review.html.erb", offer: @offer, review: Review.new)
  # review card with newly added review
  json.review json.partial!("reviews/review_card.html.erb", review: @review)
else
  # same form with errors
  json.form json.partial!("reviews/form_review.html.erb", offer: @offer, review: @review)
end
