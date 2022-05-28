require 'json'
require 'open-uri'
require 'date'
require 'time'

coordinates = {
  "Berlin": {
    latitude: 52.520008,
    longitude: 13.404954
  },
  "Munich": {
    latitude: 48.135124,
    longitude: 11.581981
  },
  "Hamburg": {
    latitude: 53.551086,
    longitude: 9.993682
  },
  "Cologne": {
    latitude: 50.937531,
    longitude: 6.960279
  },
  "Stuttgart": {
    latitude: 48.775845,
    longitude: 9.182932
  }
}

namespace :offerSeeds do
  desc "Seeding current events from Event Collector API"
  task :meetup, [:city, :radius] => :environment do |task, args|

    # starting seed API logic
    puts "start of API seed for city #{args.city} and radius #{args.radius}"
    puts ""
    # Geocoder caused 500 Internal Server Errors
    # latitude = Geocoder.search(args.city)[0].data["lat"]
    # longitude = Geocoder.search(args.city)[0].data["lon"]
    city = args.city
    radius = args.radius

    # Array to catch all the tags that were unsuccessfully seeded.
    error_array = []

    Tag.all.each do |tag|
      event_api_url = "https://event-collector-api.herokuapp.com/meetupql?activity=#{tag.name}&lat=#{coordinates[city.to_sym][:latitude]}&lon=#{coordinates[city.to_sym][:longitude]}&radius=#{radius}"

      puts ""
      puts "Accessing Event Collector API for tag #{tag.name}"

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
      puts "#{data["Info"]["EventCount"]} offers exist for #{tag.name}"
      if data["Info"]["EventCount"] > 20
        puts "Limit of 20 will be created."
      end

      sleep(3)

      created_count = 0

      data["Data"].first(20).each do |data_entry|
        url = data_entry["eventUrl"]

        if Offer.find_by_url(url).nil? == false
          puts "Offer already in database, skipping to next offer."
          next
        end

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

        external_image_url = data_entry["imageUrl"]

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
        created_count += 1
      end

      puts ""
      puts "#{created_count} offers were created for #{tag.name}"
    end
    # end of seed API logic

    # listing all the tags with errors

    puts "Tags with errors, rerun: #{error_array}"
    # closing the namespace
  end
end
