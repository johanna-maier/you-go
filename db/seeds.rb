# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require "faker"

# puts 'Deleting current reviews, bookings, favourites, offers, users, \
# tags & Ahoy events/visits'
Review.destroy_all
Booking.destroy_all
Favourite.destroy_all
Offer.destroy_all
Tag.destroy_all
Ahoy::Event.destroy_all
Ahoy::Visit.destroy_all
User.destroy_all

puts 'Creating 10 new tags'

tags = [
    {
      name: 'baseball',
      category: 'ballsports',
      img_files: ['baseball1.jpg','baseball2.jpg','baseball3.jpg']
    },
    {
      name: 'basketball',
      category: 'basket',
      img_files: ['basket1.jpg','basket2.jpg','basket3.jpg']
    },
    {
      name: 'bouldering',
      category: 'climbing',
      img_files: ['bouldering1.jpg','bouldering2.jpg','bouldering3.jpg']
    },
    {
      name: 'kayaking',
      category: 'watersports',
      img_files: ['kayak1.jpg','kayak2.jpg','kayak3.jpg']
    },
    {
      name: 'muay-thai',
      category: 'combat sport',
      img_files: ['muay-thai1.jpg','muay-thai2.jpg','muay-thai3.jpg']
    },
    {
      name: 'soccer',
      category: 'ballsports',
      img_files: ['soccer1.jpg','soccer2.jpg','soccer3.jpg']
    },
    {
      name: 'surfing',
      category: 'watersports',
      img_files: ['surfing1.jpg','surfing2.jpg','surfing3.jpg']
    },
    {
      name: 'swimming',
      category: 'watersports',
      img_files: ['swimming1.jpg','swimming2.jpg','swimming3.jpg']
    },
    {
      name: 'tennis',
      category: 'ballsports',
      img_files: ['tennis1.jpg','tennis2.jpg','tennis3.jpg']
    },
    {
      name: 'volleyball',
      category: 'ballsports',
      img_files: ['volleyball1.jpg','volleyball2.jpg','volleyball3.jpg']
    }
]


puts 'Seeding 9 sample users'

users = [
    {
      first_name: 'Johanna',
      last_name: 'Maier',
      description: "Hi, my name is Johanna! I want to go on my next sporting adventure.",
      email: 'johanna@gmail.com',
      password: '123456',
      img_file: 'johanna-profile.jpg',
      gender: 'female',
      date_of_birth: DateTime.strptime("01/25/1993", "%m/%d/%Y"),
      img_files: ['basket1.jpg','basket2.jpg','basket3.jpg']
    },
    {
      first_name: 'Anjali',
      last_name: 'Kumar',
      description: "Hi, my name is Anjali! I want to go on my next sporting adventure.",
      email: 'anjali@gmail.com',
      password: '123456',
      img_file: 'anjali-profile.jpg',
      gender: 'female',
      date_of_birth: DateTime.strptime("01/25/1993", "%m/%d/%Y")
    },
    {
      first_name: 'Alexandra',
      last_name: 'Stroe',
      description: "Hi, my name is Alexandra! I want to go on my next sporting adventure.",
      email: 'alexandra@gmail.com',
      password: '123456',
      img_file: 'alexandra-profile.jpg',
      gender: 'female',
      date_of_birth: DateTime.strptime("01/25/1993", "%m/%d/%Y")
    },
    {
      first_name: 'Ieva',
      last_name: 'Jirgensone',
      description: "Hi, my name is Ieva! I want to go on my next sporting adventure.",
      email: 'ieva@gmail.com',
      password: '123456',
      img_file: 'ieva-profile.jpg',
      gender: 'female',
      date_of_birth: DateTime.strptime("01/25/1993", "%m/%d/%Y")
    },
    {
      first_name: 'Daniel',
      last_name: 'Angerer',
      description: "Hi, my name is Daniel! I want to go on my next sporting adventure.",
      email: 'daniel@gmail.com',
      password: '123456',
      img_file: 'daniel-profile.jpg',
      gender: 'male',
      date_of_birth: DateTime.strptime("01/25/1993", "%m/%d/%Y")
    },
    {
      first_name: 'Julian',
      last_name: 'Muhlbauer',
      description: "Hi, my name is Julian! I want to go on my next sporting adventure.",
      email: 'julian@gmail.com',
      password: '123456',
      img_file: 'julian-profile.jpg',
      gender: 'male',
      date_of_birth: DateTime.strptime("01/25/1993", "%m/%d/%Y")
    },
    {
      first_name: 'Shreetama',
      last_name: 'Karmakar',
      description: "Hi, my name is Shreetama! I want to go on my next sporting adventure.",
      email: 'shreetama@gmail.com',
      password: '123456',
      img_file: 'shreetama-profile.jpg',
      gender: 'female',
      date_of_birth: DateTime.strptime("01/25/1993", "%m/%d/%Y")
    },
    {
      first_name: 'Andrew',
      last_name: 'Erlanger',
      description: "Hi, my name is Andrew! I want to go on my next sporting adventure.",
      email: 'andrew@gmail.com',
      password: '123456',
      img_file: 'andrew-profile.jpg',
      gender: 'male',
      date_of_birth: DateTime.strptime("01/25/1993", "%m/%d/%Y")
    },
    {
      first_name: 'Killian',
      last_name: 'Dectot',
      description: "Hi, my name is Killian! I want to go on my next sporting adventure.",
      email: 'killian@gmail.com',
      password: '123456',
      img_file: 'kilian-profile.jpg',
      gender: 'male',
      date_of_birth: DateTime.strptime("01/25/1993", "%m/%d/%Y")
    }
]

users.each_with_index do |user, index|
  puts "Seed users (#{index + 1}/#{users.length})"

  seed_user = User.new(
    first_name: user[:first_name],
    last_name: user[:last_name],
    description: user[:description],
    gender: user[:gender],
    date_of_birth: user[:date_of_birth],
    email: user[:email],
    password: user[:password]
  )
  seed_user.avatar_photo.attach(io: File.open("db/seed_images/#{user[:img_file]}"), filename: user[:img_file], content_type: 'image/jpg')
  seed_user.save!
end


puts 'Seeding 30 sample offers'

prices = [50, 33, 150, 25,30,56,40]
capacities = [5, 15, 10, 6, 7, 8, 12]

tags.each_with_index do |tag, index_tag|
  puts "Seed tags with categories (#{index_tag + 1}/#{tags.length})"

  seed_tag = Tag.new(
    name: tag[:name],
    category: tag[:category]
  )
  seed_tag.save!

  3.times do |index|
    puts "Seed offers (#{index + 1}/#{tag.length})  - #{seed_tag.name}"

    address_hash = Faker::Address.full_address_as_hash(:longitude, :latitude, :full_address)
    seed_title = [ Faker::Esport.event, Faker::Sports::Football.competition].sample
    puts "https://www.meetup.com/#{seed_title.parameterize(separator: '-')}/"


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
      is_external: true,
      url: "https://www.meetup.com/#{seed_title.parameterize(separator: '-')}/",
    )
    puts "New offer created"
    seed_offer.tag = seed_tag
    puts "Offer associated with tag"
    # adding 3 images per offer
    3.times do |i|
      img_file_name = tag[:img_files][i]
      puts img_file_name
      seed_offer.photos.attach(io: File.open("db/seed_photos/#{img_file_name}"), filename: img_file_name, content_type: 'image/jpg')
    end
    puts "Photos attached to offer"
    seed_offer.save!
  end
end


puts 'end of seed'
