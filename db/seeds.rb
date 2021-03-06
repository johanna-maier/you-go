# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require "faker"

puts ""
puts 'Deleting all entries.'
puts ""

Review.destroy_all
Booking.destroy_all
Offer.destroy_all # on-hold to avoid long reseeding
Like.destroy_all
Tag.destroy_all
# User.destroy_all

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
      location: 'Munich'
    },
    {
      first_name: 'Anjali',
      last_name: 'Kumar',
      description: "Hi, my name is Anjali! I want to go on my next sporting adventure.",
      email: 'anjali@gmail.com',
      password: '123456',
      img_file: 'anjali-profile.jpg',
      gender: 'female',
      date_of_birth: DateTime.strptime("01/25/1993", "%m/%d/%Y"),
      location: 'Berlin'
    },
    {
      first_name: 'Alexandra',
      last_name: 'Stroe',
      description: "Hi, my name is Alexandra! I want to go on my next sporting adventure.",
      email: 'alexandra@gmail.com',
      password: '123456',
      img_file: 'alexandra-profile.jpg',
      gender: 'female',
      date_of_birth: DateTime.strptime("01/25/1993", "%m/%d/%Y"),
      location: 'Berlin'
    },
    {
      first_name: 'Ieva',
      last_name: 'Jirgensone',
      description: "Hi, my name is Ieva! I want to go on my next sporting adventure.",
      email: 'ieva@gmail.com',
      password: '123456',
      img_file: 'ieva-profile.jpg',
      gender: 'female',
      date_of_birth: DateTime.strptime("01/25/1993", "%m/%d/%Y"),
      location: 'Hamburg'
    },
    {
      first_name: 'Daniel',
      last_name: 'Angerer',
      description: "Hi, my name is Daniel! I want to go on my next sporting adventure.",
      email: 'daniel@gmail.com',
      password: '123456',
      img_file: 'daniel-profile.jpg',
      gender: 'male',
      date_of_birth: DateTime.strptime("01/25/1993", "%m/%d/%Y"),
      location: 'Munich'
    },
    {
      first_name: 'Julian',
      last_name: 'Muhlbauer',
      description: "Hi, my name is Julian! I want to go on my next sporting adventure.",
      email: 'julian@gmail.com',
      password: '123456',
      img_file: 'julian-profile.jpg',
      gender: 'male',
      date_of_birth: DateTime.strptime("01/25/1993", "%m/%d/%Y"),
      location: 'Hamburg'
    },
    {
      first_name: 'Shreetama',
      last_name: 'Karmakar',
      description: "Hi, my name is Shreetama! I want to go on my next sporting adventure.",
      email: 'shreetama@gmail.com',
      password: '123456',
      img_file: 'shreetama-profile.jpg',
      gender: 'female',
      date_of_birth: DateTime.strptime("01/25/1993", "%m/%d/%Y"),
      location: 'Cologne'
    },
    {
      first_name: 'Andrew',
      last_name: 'Erlanger',
      description: "Hi, my name is Andrew! I want to go on my next sporting adventure.",
      email: 'andrew@gmail.com',
      password: '123456',
      img_file: 'andrew-profile.jpg',
      gender: 'male',
      date_of_birth: DateTime.strptime("01/25/1993", "%m/%d/%Y"),
      location: 'Cologne'
    },
    {
      first_name: 'Killian',
      last_name: 'Dectot',
      description: "Hi, my name is Killian! I want to go on my next sporting adventure.",
      email: 'killian@gmail.com',
      password: '123456',
      img_file: 'kilian-profile.jpg',
      gender: 'male',
      date_of_birth: DateTime.strptime("01/25/1993", "%m/%d/%Y"),
      location: 'Stuttgart'
    }
]

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

users.each_with_index do |user, index|
  puts "Seed users (#{index + 1}/#{users.length})"

  if User.find_by_email(user[:email]).nil? == false
    puts "User already in database, skipping to next user."
    next
  end

  seed_user = User.new(
    first_name: user[:first_name],
    last_name: user[:last_name],
    description: user[:description],
    gender: user[:gender],
    date_of_birth: user[:date_of_birth],
    email: user[:email],
    password: user[:password],
    location: user[:location],
    latitude: coordinates[user[:location].to_sym][:latitude],
    longitude: coordinates[user[:location].to_sym][:longitude]
  )
  seed_user.avatar_photo.attach(io: File.open("db/seed_photos/#{user[:img_file]}"), filename: user[:img_file], content_type: 'image/jpeg')
  seed_user.save!

end

puts ""
puts 'Creating 36 new tags'
puts ""
# TODO Change icons - include free icons only
tags = [
          {
              name: 'ballsports',
              category: 'ballsports',
              icon: '<i class="fas fa-volleyball-ball"></i>',
              img_file: 'ballsports_tag.jpeg'
          },
          {
              name: 'baseball',
              category: 'ballsports',
              icon: '<i class="fas fa-baseball-ball"></i>',
              img_file: 'ballsports_tag.jpeg'
          },
          {
              name: 'basketball',
              category: 'ballsports',
              icon: '<i class="fas fa-basketball-ball"></i>',
              img_file: 'ballsports_tag.jpeg'
          },
          {
              name: 'bowling',
              category: 'ballsports',
              icon: '<i class="fas fa-bowling-ball"></i>',
              img_file: 'ballsports_tag.jpeg'
          },
          {
              name: 'football',
              category: 'ballsports',
              icon: '<i class="fas fa-futbol"></i>',
              img_file: 'ballsports_tag.jpeg'
          },
          {
              name: 'volleyball',
              category: 'ballsports',
              icon: '<i class="fas fa-volleyball-ball"></i>',
              img_file: 'ballsports_tag.jpeg'
          },
          {
              name: 'biking',
              category: 'biking',
              icon: '<i class="fas fa-bicycle"></i>',
              img_file: 'biking_tag.jpeg'
          },
          {
              name: 'bouldering',
              category: 'climbing',
              icon: '<i class="fas fa-hand-rock"></i>',
              img_file: 'climbing_tag.jpeg'
          },
          {
              name: 'climbing',
              category: 'climbing',
              icon: '<i class="fas fa-hand-rock"></i>',
              img_file: 'climbing_tag.jpeg'
          },
          {
              name: 'karate',
              category: 'combat sports',
              icon: '<i class="fas fa-hand-paper"></i>',
              img_file: 'combat_tag.jpeg'
          },
          {
              name: 'salsa',
              category: 'dancing',
              icon: '<i class="fas fa-music"></i>',
              img_file: 'dancing_tag.jpeg'
          },
          {
              name: 'dancing',
              category: 'dancing',
              icon: '<i class="fas fa-music"></i>',
              img_file: 'dancing_tag.jpeg'
          },
          {
              name: 'hiking',
              category: 'hiking',
              icon: '<i class="fas fa-hiking"></i>',
              img_file: 'hiking_tag.jpeg'
          },
          {
              name: 'racket sports',
              category: 'racket sports',
              icon: '<i class="fas fa-table-tennis"></i>',
              img_file: 'racket_tag.jpeg'
          },
          {
              name: 'table tennis',
              category: 'racket sports',
              icon: '<i class="fas fa-table-tennis"></i>',
              img_file: 'racket_tag.jpeg'
          },
          {
              name: 'running',
              category: 'running',
              icon: '<i class="fas fa-running"></i>',
              img_file: 'running_tag.jpeg'
          },
          {
              name: 'skating',
              category: 'skating',
              icon: '<i class="fas fa-skating"></i>',
              img_file: 'skating_tag.jpeg'
          },
          {
              name: 'fitness',
              category: 'fitness',
              icon: '<i class="fas fa-dumbbell"></i>',
              img_file: 'fitness_tag.jpeg'
          },
          {
              name: 'canoe',
              category: 'watersports',
              icon: '<i class="fas fa-water"></i>',
              img_file: 'watersports_tag.jpeg'
          },
          {
              name: 'fishing',
              category: 'watersports',
              icon: '<i class="fas fa-fish"></i>',
              img_file: 'watersports_tag.jpeg'
          },
          {
              name: 'kayaking',
              category: 'watersports',
              icon: '<i class="fas fa-water"></i>',
              img_file: 'watersports_tag.jpeg'
          },
          {
              name: 'sailing',
              category: 'watersports',
              icon: '<i class="fas fa-anchor"></i>',
              img_file: 'watersports_tag.jpeg'
          },
          {
              name: 'SUP',
              category: 'watersports',
              icon: '<i class="fas fa-water"></i>',
              img_file: 'watersports_tag.jpeg'
          },
          {
              name: 'surfing',
              category: 'watersports',
              icon: '<i class="fas fa-water"></i>',
              img_file: 'watersports_tag.jpeg'
          },
          {
              name: 'watersports',
              category: 'watersports',
              icon: '<i class="fas fa-water"></i>',
              img_file: 'watersports_tag.jpeg'
          },
          {
              name: 'skiing',
              category: 'wintersports',
              icon: '<i class="fas fa-skiing"></i>',
              img_file: 'wintersports_tag.jpeg'
          },
          {
              name: 'snowboarding',
              category: 'wintersports',
              icon: '<i class="fas fa-snowboarding"></i>',
              img_file: 'wintersports_tag.jpeg'
          },
          {
              name: 'wintersports',
              category: 'wintersports',
              icon: '<i class="fas fa-snowflake"></i>',
              img_file: 'wintersports_tag.jpeg'
          },
          {
              name: 'yoga',
              category: 'yoga',
              icon: '<i class="fas fa-praying-hands"></i>',
              img_file: 'yoga_tag.jpeg'
          }
]

tags.each_with_index do |tag, index|
  puts "Seed tags with categories (#{index + 1}/#{tags.length})"
  seed_tag = Tag.new(
    name: tag[:name],
    category: tag[:category],
    icon: tag[:icon]
  )
  seed_tag.photo.attach(io: File.open("db/seed_photos/#{tag[:img_file]}"), filename: tag[:img_file], content_type: 'image/jpeg')
  seed_tag.save!
end

puts ""
puts 'end of initial seed'
puts ""
