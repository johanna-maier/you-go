require 'redcarpet'

module ApplicationHelper
  def markdown(text)
    options = [:hard_wrap, :autolink, :no_intra_emphasis, :fenced_code_blocks]
    Markdown.new(text, *options).to_html.html_safe
  end

  # Helper to open SVGs
  def show_svg(path)
  File.open("app/assets/images/#{path}", "rb") do |file|
      raw file.read
    end
  end
end
