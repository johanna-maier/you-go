require 'json'
require 'open-uri'



namespace :offerSeeds do
  desc "Seeding entries events from Google Maps API"
  task googleMaps: :environment do


    # https://developers.google.com/maps/documentation/places/web-service/search-text
    # maps_offers_url = "https://maps.googleapis.com/maps/api/place/textsearch/json?query=#{tag}%20in%20#{city}&key=#{ENV["GOOGLE_MAPS"]}"

    # https://developers.google.com/maps/documentation/places/web-service/photos
    # maps_pictures_url = "https://maps.googleapis.com/maps/api/place/photo?maxwidth=600&photo_reference=#{photo_reference}&key=#{ENV["GOOGLE_MAPS"]}"

    # https://uberall.helpjuice.com/de_DE/88536-google/516489-verwenden-sie-die-google-places-id
    # maps_places_id_url = "https://www.google.com/maps/search/?api=1&query=Google&query_place_id=#{place_id}"

    # starting seed API logic
    puts 'start of Google Maps API seed'
    puts ""

    # Array to catch all the tags that were unsuccessfully seeded.
    error_array = []

   Tag.first(2).each do |tag|
     # Only first 2 Tags because of Google Maps costs
     city = 'berlin'
     maps_offers_url = "https://maps.googleapis.com/maps/api/place/textsearch/json?query=#{tag.name}%20in%20#{city}&key=#{ENV["GOOGLE_MAPS"]}"

      puts ""
      puts "Accessing Google Maps API for tag #{tag.name}"

      # If response is too large, seed skips to next tag and logs unsuccessful tag in error array.
      begin
        response = URI.open(maps_offers_url).read
      rescue OpenURI::HTTPError => e
        puts "Error message: #{e.message}"
        error_array << tag
        puts "Logged tag in error array."
        puts "Skipping to next tag"
        next
      else
        puts "API URL successfully opened"
        puts ""
      end

      data = JSON.parse(response)

      puts "Creating new offer for first page of results of the tag #{tag.name}"


      sleep(3)

      data["results"].first(5).each do |data_entry|
        address = data_entry["formatted_address"]
        latitude = data_entry["geometry"]["location"]["lat"]
        longitude = data_entry["geometry"]["location"]["lng"]

        title = data_entry["name"]

        description = "Visit #{title} at #{address} for some #{tag.name}!"

        if data_entry.has_key?("photos")
          photo_reference = data_entry["photos"][0]["photo_reference"]
          external_image_url = "https://maps.googleapis.com/maps/api/place/photo?maxwidth=600&photo_reference=#{photo_reference}&key=#{ENV["GOOGLE_MAPS"]}"
        end

        place_id = data_entry["place_id"]
        maps_url = "https://www.google.com/maps/search/?api=1&query=Google&query_place_id=#{place_id}"


        seed_offer = Offer.new(
          title: title,
          description: description,
          address: address,
          latitude: latitude,
          longitude: longitude,
          is_external: true,
          url: maps_url,
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
        sleep(3)

      end

      puts ""

    end
    # end of seed API logic

    # listing all the tags with errors
    puts "Tags with errors, rerun: #{error_array}"

  end # closing the namespace
end
