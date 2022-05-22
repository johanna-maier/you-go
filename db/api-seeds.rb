require 'json'
require 'open-uri'
require 'date'
require 'time'

# tags = %w(baseball basketball bouldering kayaking muay-thai soccer surfing swimming tennis volleyball)

tags = %w(baseball)

tags.each do |tag|

  begin

    event_api_url = "https://event-collector-api.herokuapp.com/meetupql?activity=#{tag}&lat=47.259659&lon=11.400375&radius=700"
    response = URI.open(event_api_url).read
    data = JSON.parse(response)

    puts "Creating new offer for each result of the tag #{tag}"

    data["Data"].each do |data_entry|
      title = data_entry["title"]
      puts title
      description = data_entry["description"]
      puts description
      price_per_person = data_entry["fee"]
      puts price_per_person
      capacity = data_entry["numberOfAllowedGuests"]
      puts capacity

      if data_entry["venue"].nil?
        address = "not provided"
        latitute = "not provided"
        longitude = "not provided"
      else
        address = data_entry["venue"]["address"]
        latitude = data_entry["venue"]["lat"]
        longitude = data_entry["venue"]["lng"]
      end
      puts address
      puts latitude
      puts longitude

      dateTime = Time.parse(data_entry["dateTime"])
      puts dateTime
      date = dateTime.strftime("%d/%m/%Y")
      puts date
      time = dateTime.strftime("%H:%M")
      puts time

      url = data_entry["eventUrl"]
      puts url
      image_url = data_entry["imageUrl"]
      puts image_url

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
        url: url
      )
      puts "New offer created"
      seed_offer.tag = tag
      puts "Offer associated with tag"
      # adding 3 images per offer
      seed_offer.save!
    rescue
      p "Error"
      sleep(5)
      puts "Continue with next tag"
      next
    end
  end


end
