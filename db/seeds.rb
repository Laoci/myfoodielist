require 'open-uri'
require 'json'
require 'faker'
require 'pry-byebug'

# Clear the database
puts "Clearing database..."
Tag.destroy_all
Restaurant.destroy_all
User.destroy_all
Review.destroy_all
List.destroy_all
puts "Database cleared"
puts "Seeding restaurants..."

# Variables for API calls
tih_search_keyword_baseurl = "https://tih-api.stb.gov.sg/content/v1/food-beverages/search"
tih_download_image_baseurl = "https://tih-api.stb.gov.sg/media/v1/download/uuid/"
tih_api_key = ENV['TIH_API_KEY']
# pexels_api_key = ENV['PEXELS_API_KEY']
# client = Pexels::Client.new(pexels_api_key)
keywords = ["Spanish", "Italian", "Japanese", "American", "German", "French", "British", "Korean", "Thai", "Vietnamese", "Hokkien", "Teochew", "Cantonese", "Hakka", "Hainanese", "Mala", "Healthy", "Vegetarian", "Seafood", "Pizza", "Steak", "Hot Pot", "Coffee", "Ramen", "Taco"]
puts "#{keywords.length} keywords for search"
# def call_pexel(client, genre)
#   return URI.open(client.photos.search("Food #{genre}", per_page: 1).photos[0].src["tiny"])
# end

# Loop to search all keywords in API sequentially for restaurants
keywords.each do |keyword|
  # Call TIH searchFoodBeveragesByKeyword API to search the keyword and get restaurants info (15 restos for each keyword)
  res_kw = JSON.parse(URI.open("#{tih_search_keyword_baseurl}?keyword=#{keyword}&apikey=#{tih_api_key}").read)
  restaurants = res_kw["data"]
  # Parse each restaurant
  restaurants.each do |resto|
    name = resto["name"]
    address = "#{resto['address']['block']} #{resto['address']['streetName']}"
    genre = resto["cuisine"].empty? ? keyword : resto["cuisine"]
    postal_code = resto["address"]["postalCode"]
    unless resto["location"]["latitude"].zero? || resto["location"]["longitude"].zero?
      coordinates = JSON.generate(resto["location"])
    end
    # Call TIH getMediaByUUID API to get a restaurant photo (thumbnail) by its uuid
    # If a photo (thumbnail) uuid exists, get the photo url
    begin
      image_uuid = resto["images"][0]["uuid"]
      image_file = URI.open("#{tih_download_image_baseurl}#{image_uuid}?fileType=Thumbnail%201080h&apikey=#{tih_api_key}")
    rescue
      image_file = nil
    end
    # binding.pry
    if !image_file.nil? && (image_file.instance_of?(Tempfile)) && coordinates
      # Create a new restaurant instance, attach the photo and save
      new_restaurant = Restaurant.new(name: name, address: address, genre: genre, postal_code: postal_code, coordinates: coordinates)
      new_restaurant.photo.attach(io: image_file, filename: "#{name}.jpg", content_type: 'image/jpg')
      puts "#{name} photo attached" if new_restaurant.photo.attached?
      puts "#{name} saved" if new_restaurant.save
    end
  end
end
puts "Restaurants created"

# Generate users
puts "Seeding users..."
5.times do
  username = Faker::Name.name
  password = Faker::Name.initials(number: 6)
  email = Faker::Internet.email

  new_user = User.new(username: username, email: email, password: password)
  puts "#{username} saved, Email: #{email}, PW: #{password}" if new_user.save
end
test_user = User.new(username: "John Smith", email: "johnsmith@gmail.com", password: 123456)
puts "John Smith saved, Email: johnsmith@gmail.com, PW: 123456" if test_user.save
puts "Users created"

# Generate reviews and assign them under different users and restaurants randomly
puts "Seeding reviews and ratings..."
Restaurant.all.each do |restaurant|
  5.times do
    content = Faker::Restaurant.review
    rating = Faker::Number.between(from: 3, to: 5)
    review = Review.new(content: content, rating: rating, user: User.order("RANDOM()").first, restaurant: restaurant)
    review.save!
  end
end
puts "Reviews and ratings created"

# Generate 2 lists for each user
puts "Seeding lists..."
User.all.each do |user|
  2.times do
    list_name = Restaurant.order("RANDOM()").first.genre.split[0]
    list = List.new(user: user, shared: false, name: list_name)
    list.save!
    list.restaurants << Restaurant.where("restaurants.genre @@ :type", type: "%#{list_name}%").limit(5)
  end
end
puts "Lists created"

# Generate tags for each restaurant
puts "Seeding tags..."
Restaurant.all.each do |restaurant|
  User.all.each do |user|
    2.times do
      tag_name = Faker::Coffee.variety
      tag = Tag.new(name: tag_name, user: user, restaurant: restaurant)
      tag.save!
    end
  end
end
puts "Tags created"
puts "Seeding finished"
