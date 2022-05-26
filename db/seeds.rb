# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require "faker"

puts ""
puts 'Deleting current reviews, bookings, favourites, offers, users, tags & Ahoy events/visits'
puts ""

Review.destroy_all
Booking.destroy_all
Favourite.destroy_all
Offer.destroy_all
Tag.destroy_all
Ahoy::Event.destroy_all
Ahoy::Visit.destroy_all
User.destroy_all

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
      img_file: 'killian-profile.jpg',
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
  seed_user.avatar_photo.attach(io: File.open("db/seed_photos/#{user[:img_file]}"), filename: user[:img_file], content_type: 'image/jpg')
  seed_user.save!
end

puts ""
puts 'Creating 10 new tags'
puts ""

tags = [
    {
      name: 'baseball',
      category: 'ballsports'
    },
    {
      name: 'basketball',
      category: 'basket'
    },
    {
      name: 'bouldering',
      category: 'climbing'
    },
    {
      name: 'kayaking',
      category: 'watersports'
    },
    {
      name: 'muay-thai',
      category: 'combat sport'
    },
    {
      name: 'soccer',
      category: 'ballsports'
    },
    {
      name: 'surfing',
      category: 'watersports'
    },
    {
      name: 'swimming',
      category: 'watersports'
    },
    {
      name: 'tennis',
      category: 'ballsports'
    },
    {
      name: 'volleyball',
      category: 'ballsports'
    }
]

tags.each_with_index do |tag, index|
  puts "Seed tags with categories (#{index + 1}/#{tags.length})"
  seed_tag = Tag.new(
    name: tag[:name],
    category: tag[:category]
  )

  seed_tag.save!
end

puts ""
puts 'end of initial seed'
puts ""
