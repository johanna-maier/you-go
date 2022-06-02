namespace :offerSeeds do
  desc "Seeding fake events representing offers created on platform."
  task fake: :environment do
    puts ""
    puts 'Seeding 10 sample offers'
    puts ""

    prices = [50, 33, 150, 25,30,56,40]
    capacities = [5, 15, 10, 6, 7, 8, 12]

    tags = {
      'baseball': {
        tag_images: ['baseball1.jpg','baseball2.jpg','baseball3.jpg'],
        title: "Berlin Skylarks Baseball and Softball Training",
        description: "We are the Berlin Skylarks, the baseball and softball division of the TiB 1848 e.V. We are open to anyone who wants to play baseball and softball in the heart of Berlin, regardless of age, nationality, gender or previous playing experience. All you have to do is write us a quick message and come to one of our practices. We have teams at every level of competition, so there are no tryouts or anything similar – you just drop by and we will find a place for you.",
        address: "Rathausstraße 7, 10178 Berlin",
        latitude: 52.519710,
        longitude: 13.410720
      },
      'basketball': {
        tag_images: ['basket1.jpg','basket2.jpg','basket3.jpg'],
        title: "Roter Stern Berlin 2012 e.V.",
        description: "As part of Roter Stern Berlin 2012 e.V., we organise various sports activities, such as basketball, together with refugees and neighbours. The fun with the game is in the foreground of this sports offer. It also aims to facilitate an exchange between people from different backgrounds. Like all Roter Stern activities, we offer a framework in which sports can be played in a relaxed way without anyone having to fear discrimination because of their origin, gender or sexual orientation. We are looking forward to meeting you!",
        address: "Böttgerstraße 8, 13357 Berlin",
        latitude: 52.520062,
        longitude: 13.379800
      },
      'bouldering': {
        tag_images: ['bouldering1.jpg','bouldering2.jpg','bouldering3.jpg'],
        title: "Basement Boulderstudio Highlight",
        description: "Bouldering is quickly becoming one of the most popular sports at Urban Sports Club. And it’s no wonder: this total-body workout has numerous benefits, including strength training, cardio and improving balance and concentration. With Urban Sports Club, you can try out bouldering and over 50 other sports with just one flexible membership. Head to the bouldering hall in the morning for a pre-work climb, or make it a group activity with friends or colleagues after a long day at the office. Regardless of when or where you want to train, Urban Sports Club is your one-stop-shop for variety and flexibility. Are you a member yet?",
        address: "Stresemannstraße 72, 10963 Berlin",
        latitude: 52.549310,
        longitude: 13.384420

      },
      'kayaking': {
        tag_images: ['kayak1.jpg','kayak2.jpg','kayak3.jpg'],
        title: "Kajak Berlin Tours",
        description: "Enjoy the stunning waterscape of the legendary Landwehrkanal and the Spree River! Discover an unexpected oasis in the middle of the city caused by a switch of your perspective and the kind of movement. A REAL DAYDREAM! With the best equipment – comfortable kayaks, life vests, spray decks – and professionally guided in small groups we provide you an unique and safe experience.",
        address: "Kayak-Truck vis-á-vis Cafe A.Horn, Carl-Herz-Ufer 9, 10961 Berlin",
        latitude: 52.495747,
        longitude: 13.405571
      },
      'football': {
        tag_images: ['soccer1.jpg','soccer2.jpg','soccer3.jpg'],
        title: "KICKERWorld Berlin",
        description: "Berlin's most modern hall for indoor soccer! Our unique, blue artificial turf of the latest generation offers optimal conditions for an incomparable playing experience. The 3 soccer courts extend over an area of 30*15 meters each and are separated from each other by a professional barrier system. *  The beach court in our outdoor area is perfect for a thrilling game of beach soccer or volleyball in summer. And for those who long for a refreshing drink or a snack after their sporting activities, we welcome you at our beach bar in the garden or in our restaurant, depending on the weather.",
        address: "Kleine Eiswerderstraße 1, 13599 Berlin",
        latitude: 52.5490074,
        longitude: 13.226816
      },
      'surfing': {
        tag_images: ['surfing1.jpg','surfing2.jpg','surfing3.jpg'],
        title: "Wellenwerk Berlin",
        description: "Welcome to Germany’s first Deus Temple “The Fountain of Eternal Effervescence”. Behind the large panoramic windows facing the wave area, every cocktail at the Deus Fountain Bar is a special treat. In the Deus Restaurant, you can enjoy innovative cuisine with regional and seasonal products. Germany’s first Deus Ex Machina shop also lives inside our Deus Temple. From boardshorts, wetsuits to jackets and t-shirts, here you will find everything you need for a casual look in everyday life or on the water whilst surfing. You can find more information about our restaurant concept, the surf shop & the surfboard repair shop here.",
        address: "Landsberger Allee 270, 10367 Berlin",
        latitude: 52.5334217,
        longitude: 13.48107

      },
      'volleyball': {
        tag_images: ['volleyball1.jpg','volleyball2.jpg','volleyball3.jpg'],
        title: "Beach Mitte",
        description: "On the right a coctail bar, on the left chilly sunbathing areas, in front a long desert with over 50 beach volleyball courts and in the back the TV tower can be seen. Beach Mitte has the most beach volleyball courts in Berlin and is accordingly a hotspot for every volleyball player. You can already feel that when you walk into the facility. Here you will meet all kinds of players, from a beginner to a professional who has played world tour several times. In Beach Mitte you can also play in the evening when it gets dark. For this purpose there are floodlights all over the facility. Beach Mitte is known for its beautiful beach bar and a climbing park. The beach bar can also be used by players in the summer, for example to have a cool drink after an intense sports session. The beach bar has over 400 seats.",
        address: "Caroline-Michaelis-Straße 8, 10115 Berlin",
        latitude: 52.5342628,
        longitude: 13.3838729
      }
    }



    tags.each do |key, value|
        tag = Tag.find_by_name(key.to_sym)
        puts "Seed offer for #{tag.name}"

        seed_offer = Offer.new(
          title: tags[tag.name.to_sym][:title],
          description: tags[tag.name.to_sym][:description],
          price_per_person: prices.sample,
          capacity: capacities.sample,
          address: tags[tag.name.to_sym][:address],
          latitude: tags[tag.name.to_sym][:latitude],
          longitude: tags[tag.name.to_sym][:longitude],
          offer_date: Faker::Date.forward(days: (1..20).to_a.sample),
          offer_time: Faker::Time.forward(days: (1..20).to_a.sample, period: :evening),
          is_external: false
        )

        if Offer.find_by_title(seed_offer.title).nil? == false
          puts "Offer already in database, skipping to next offer."
          next
        end

        puts "New offer created"
        seed_offer.tag = tag
        puts "Offer associated with tag"

        puts tags[tag.name.to_sym]
        # adding 3 images per offer
        3.times do |i|
          img_file_name = tags[tag.name.to_sym][:tag_images][i]
          puts img_file_name
          seed_offer.photos.attach(io: File.open("db/seed_photos/#{img_file_name}"), filename: img_file_name, content_type: 'image/jpg')
        end
        puts ""
        puts "Photos attached to offer"
        puts ""



       seed_offer.save!

    end
    # closing the namespace
    puts "All fake offers seeded"
  end
end
