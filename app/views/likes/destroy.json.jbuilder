if @like.destroyed?
  # return grey heart icon
  json.success "true"
  json.icon json.partial!("likes/grey_icon.html.erb", offer: @offer)
else
  json.success "false"
  json.error_msg @like.errors.messages
end
