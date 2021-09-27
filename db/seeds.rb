# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# create restaurant seed --------------------------------------

puts "Clearing database..."
User.destroy_all
Restaurant.destroy_all
Review.destroy_all
List.destroy_all
Tag.destroy_all

puts "Creating restaurants..."

50.times do
  restaurant_name = Faker::Restaurant.name
  postal = Faker::Number.number(digits: 6)
  address = Faker::Address.street_name
  genre = Faker::Restaurant.type

  resto = Restaurant.new(name: restaurant_name, address: address, postal_code: postal, genre: genre)
  resto.save!

  puts "Creating users..."

  username = Faker::Name.name
  password = Faker::Name.initials(number: 7)
  email = Faker::Internet.email

  new_user = User.new(username: username, email: email, password: password)
  new_user.save!

  puts "Creating reviews and ratings..."
  3.times do
    content = Faker::Restaurant.review
    rating = Faker::Number.between(from: 3, to: 5)

    review = Review.new(content: content, rating: rating, user: new_user, restaurant: resto)

    review.save!
  end

  puts "Creating lists..."
  5.times do
    list = List.new(user: new_user, shared: false, name: "#{genre[0...10]}")
    list.save!
    list.restaurants << Restaurant.limit(5)
  end

  puts "creating tags..."
  2.times do
    variety = Faker::Dessert.variety
    tag = Tag.new(name: variety, user: new_user, restaurant: resto)
    tag.save!
  end
end

test_user = User.new(username: "John Doe", email: "johndoe@gmail.com", password: 123456)
test_user.save!

list_a = List.create(user: test_user, shared: false, name: "List A")
list_a.restaurants << Restaurant.limit(5)
list_a.save!

list_b = List.create(user: test_user, shared: false, name: "List B")
list_b.restaurants << Restaurant.limit(5)
list_b.save!

list_c = List.create(user: test_user, shared: false, name: "List C")
list_c.restaurants << Restaurant.limit(5)
list_c.save!

puts "Seeding finished"
