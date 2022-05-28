if @like.persisted?
  # return red heart icon
  json.success "true"
  json.icon json.partial!("likes/red_icon.html.erb", offer: @offer, like: @like)
else
  json.success "false"
  json.error_msg @like.errors.messages
end
