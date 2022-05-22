require 'json'
require 'open-uri'
require 'date'
require 'time'

namespace :offerSeeds do
  desc "Seeding current events from Event Collector API"
  task meetup: :environment do

    # starting seed API logic
    puts 'start of API seed'
    puts ""

    # Array to catch all the tags that were unsuccessfully seeded.
    error_array = []

    Tag.all.each do |tag|
      puts ""
      puts "Accessing Event Collector API for tag #{tag.name}"
      # Lat & long = center of Germany and 500km radius around.
      event_api_url = "https://event-collector-api.herokuapp.com/meetupql?activity=#{tag.name}&lat=51.165691&lon=10.451526&radius=500"

      # If response is too large, seed skips to next tag and logs unsuccessful tag in error array.
      begin
        response = URI.open(event_api_url).read
      rescue OpenURI::HTTPError => e
        puts "Error message: #{e.message}"
        error_array << tag.name
        puts "Logged tag in error array."
        puts "Skipping to next tag"
        next
      else
        puts "API URL successfully opened"
        puts ""
      end

      data = JSON.parse(response)

      puts "Creating new offer for each result of the tag #{tag.name}"
      puts "#{data["Info"]["EventCount"]} offers will be created for #{tag.name}"

      sleep(3)

      data["Data"].each do |data_entry|
        title = data_entry["title"]

        if data_entry["description"].blank?
          description = "no description"
        else
          description = data_entry["description"]
        end

        price_per_person = data_entry["fee"].to_i

        if data_entry["numberOfAllowedGuests"].zero?
          capacity = nil
        else
          capacity = data_entry["numberOfAllowedGuests"].to_i
        end

        if data_entry["venue"].nil?
          address = "no address provided"
          latitude = "no latitude"
          longitude = "no longitude"
        elsif data_entry["venue"]["address"] == ""
          address = "no address provided"
          latitude = data_entry["venue"]["lat"]
          longitude = data_entry["venue"]["lng"]
        else
          address = data_entry["venue"]["address"]
          latitude = data_entry["venue"]["lat"]
          longitude = data_entry["venue"]["lng"]
        end

        date_time = Time.parse(data_entry["dateTime"])
        date = date_time.strftime("%d/%m/%Y")
        time = date_time.strftime("%H:%M")

        url = data_entry["eventUrl"]

        external_image_url = data_entry["imageUrl"]
        puts external_image_url

        seed_offer = Offer.new(
          title: title,
          description: description,
          price_per_person: price_per_person,
          capacity: capacity,
          address: address,
          latitude: latitude,
          longitude: longitude,
          offer_date: date,
          offer_time: time,
          is_external: true,
          url: url,
          external_image_url: external_image_url
        )
        puts "New offer created"


        seed_offer.tag = tag
        puts "Offer associated with tag"
        # adding 3 images per offer
        seed_offer.save!

        puts "Offer saved to DB"
        puts ""
        puts "____"
        p seed_offer
        puts "____"
        puts ""

      end

      puts ""
      puts "#{data["Info"]["EventCount"]} offers were created for #{tag.name}"

    end
    # end of seed API logic

    # listing all the tags with errors

    puts "Tags with errors, rerun: #{error_array}"
    # closing the namespace
  end
end
