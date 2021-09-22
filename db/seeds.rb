# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

puts "creating restaurants..."
30.times do
  restaurant_name = Faker::Restaurant.name
  postal = Faker::Number.number(digits: 6)
  address = Faker::Address.street_name
  genre = Faker::Restaurant.type

  resto = Restaurant.new(name: restaurant_name, address: address, postal_code: postal, genre: genre)
  resto.save!
end
