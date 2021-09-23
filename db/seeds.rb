# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# create restaurant seed --------------------------------------

puts "creating restaurants..."
30.times do
  restaurant_name = Faker::Restaurant.name
  postal = Faker::Number.number(digits: 6)
  address = Faker::Address.street_name
  genre = Faker::Restaurant.type

  resto = Restaurant.new(name: restaurant_name, address: address, postal_code: postal, genre: genre)
  resto.save!

  username = Faker::Name.name
  password = Faker::Name.initials(number: 7)
  email = Faker::Internet.email

  user = User.new(username: username, email: email, password: password)
  user.save!

  puts "creating reviews and ratings....."
  5.times do
    content = Faker::Restaurant.review
    rating = Faker::Number.between(from: 1, to: 5)

    review = Review.new(content: content, rating: rating, user: user, restaurant: resto)

    review.save!
  end
end
