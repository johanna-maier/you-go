namespace :offerSeeds do
  desc "Seeding current events from Event Collector API"
  task fake: :environment do
    puts ""
    puts 'Seeding 30 sample offers'
    puts ""

    prices = [50, 33, 150, 25,30,56,40]
    capacities = [5, 15, 10, 6, 7, 8, 12]

    tag_images = {
      'baseball': ['baseball1.jpg','baseball2.jpg','baseball3.jpg'],
      'basketball': ['basket1.jpg','basket2.jpg','basket3.jpg'],
      'bouldering': ['bouldering1.jpg','bouldering2.jpg','bouldering3.jpg'],
      'kayaking': ['kayak1.jpg','kayak2.jpg','kayak3.jpg'],
      'muay-thai': ['muay-thai1.jpg','muay-thai2.jpg','muay-thai3.jpg'],
      'soccer': ['soccer1.jpg','soccer2.jpg','soccer3.jpg'],
      'surfing': ['surfing1.jpg','surfing2.jpg','surfing3.jpg'],
      'swimming': ['swimming1.jpg','swimming2.jpg','swimming3.jpg'],
      'tennis': ['tennis1.jpg','tennis2.jpg','tennis3.jpg'],
      'volleyball': ['volleyball1.jpg','volleyball2.jpg','volleyball3.jpg']
    }

    Tag.all.each do |tag|

      3.times do |index|
        puts "Seed offers (#{index + 1}/#{Tag.count})  - #{tag.name}"

        address_hash = Faker::Address.full_address_as_hash(:longitude, :latitude, :full_address)
        seed_title = [ Faker::Esport.event, Faker::Sports::Football.competition].sample

        seed_offer = Offer.new(
          title: seed_title,
          description: "#{Faker::GreekPhilosophers.name} | #{Faker::GreekPhilosophers.quote}",
          price_per_person: prices.sample,
          capacity: capacities.sample,
          address: address_hash[:full_address],
          latitude: address_hash[:latitude],
          longitude: address_hash[:longitude],
          offer_date: Faker::Date.forward(days: (1..20).to_a.sample),
          offer_time: Faker::Time.forward(days: (1..20).to_a.sample, period: :evening),
          is_external: false
        )
        puts "New offer created"
        seed_offer.tag = tag
        puts "Offer associated with tag"
        # adding 3 images per offer
        3.times do |i|
          img_file_name = tag_images[tag.name.to_sym][i]
          puts img_file_name
          seed_offer.photos.attach(io: File.open("db/seed_photos/#{img_file_name}"), filename: img_file_name, content_type: 'image/jpg')
        end
        puts ""
        puts "Photos attached to offer"
        puts ""

        seed_offer.save!
      end
    end
    # closing the namespace
    puts "All fake offers seeded"
  end
end
