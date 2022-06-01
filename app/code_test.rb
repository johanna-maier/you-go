# Imports the Google Cloud client library
require "google/cloud/translate"

# Your Google Cloud Platform project ID
project_id = ENV["CLOUD_PROJECT_ID"]

# Instantiates a client
translate = Google::Cloud::Translate.new project: project_id

# The text to translate
text = "Hello, world!"
# The target language
target = "ru"

# Translates some text into Russian
translation = translate.translate text, to: target

puts "Text: #{text}"
puts "Translation: #{translation}"
