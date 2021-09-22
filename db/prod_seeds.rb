require 'open-uri'
require 'json'
require 'pexels'
require 'pry-byebug'

# Clear the database
Restaurant.destroy_all
puts "Database cleared"
puts "Start restaurant seeding"

tih_search_keyword_baseurl = "https://tih-api.stb.gov.sg/content/v1/food-beverages/search"
tih_search_image_baseurl = "https://tih-api.stb.gov.sg/media/v1/media/uuid/"
tih_api_key = ENV['TIH_API_KEY']
pexels_api_key = ENV['PEXELS_API_KEY']
client = Pexels::Client.new(pexels_api_key)
keywords = ["Spanish", "Italian", "Japanese", "Singaporean", "Chinese", "Indian", "Healthy", "Vegetarian", "Cafe", "Pizza"]

def call_pexel(client, genre)
  return URI.open(client.photos.search("Food #{genre}", per_page: 1).photos[0].src["tiny"])
end

# Loop to search all keywords sequentially
keywords.each do |keyword|
  # Call TIH searchFoodBeveragesByKeyword API to search the keyword and get restaurants info (15 restos for each keyword)
  res_kw = JSON.parse(URI.open("#{tih_search_keyword_baseurl}?keyword=#{keyword}&apikey=#{tih_api_key}").read)
  restaurants = res_kw["data"].length > 15 ? res_kw["data"][0...15] : res_kw["data"][0...5]
  restaurants.each do |resto|
    name = resto["name"]
    address = "#{resto['address']['block']} #{resto['address']['streetName']}"
    genre = resto["cuisine"].empty? ? keyword : resto["cuisine"]
    postal_code = resto["address"]["postalCode"]

    # Call TIH getMediaByUUID API to get a restaurant photo (thumbnail) by its uuid
    # If a photo (thumbnail) uuid exists, get the photo url
    begin
      thumb_uuid = resto["thumbnails"][0]["uuid"]
      res_thumb = JSON.parse(URI.open("#{tih_search_image_baseurl}#{thumb_uuid}?apikey=#{tih_api_key}").read)
      thumb_file = URI.open("#{res_thumb['data']['url']}?apikey=#{tih_api_key}")
    rescue
      thumb_file = nil
    end

    if thumb_file
      # Create a new restaurant instance, attach the photo and save
      new_restaurant = Restaurant.new(name: name, address: address, genre: genre, postal_code: postal_code)
      new_restaurant.photo.attach(io: thumb_file, filename: "#{name}.jpg", content_type: 'image/jpg')
      puts "#{name} photo attached" if new_restaurant.photo.attached?
      puts "#{name} saved" if new_restaurant.save
    end
  end
end

puts "---------------------------"
puts "Restaurant seeding finished"
