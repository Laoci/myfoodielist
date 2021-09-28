class Restaurant < ApplicationRecord
  # Name of restaurant, must have name, name must be unique and minimum 3 characters
  validates :name, presence: true, length: { minimum: 3 }

  # Must have address, at least 6 characters
  validates :address, presence: true, length: { minimum: 6 }

  # Must have genre
  validates :genre, presence: true

  # Must have postal code, must be numbers, exact length is 6
  validates :postal_code, presence: true
  validates :postal_code, length: { is: 6 }

  # Associations
  has_one_attached :photo
  has_many :restaurant_lists, dependent: :destroy
  has_many :lists, through: :restaurant_lists
  has_many :reviews, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :tags, dependent: :destroy
  has_many :explores, dependent: :destroy

  def avg_rating
    rev_arr = reviews
    total_rating = 0
    rev_arr.each do |rate|
      total_rating += rate.rating
    end
    processed_rating = total_rating / reviews.count
    return processed_rating.round(1)
  end

  def tag_names
    return tags.empty? ? [] : tags.map(&:name)
  end
end
