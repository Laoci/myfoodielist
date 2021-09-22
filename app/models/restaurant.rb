class Restaurant < ApplicationRecord

  has_many :reviews, dependent: :destroy

  # Name of restaurant, must have name, name must be unique and minimum 3 characters
  validates :name, presence: true, uniqueness: false, length: { minimum: 3 }

  # Must have address, at least 8 characters
  validates :address, presence: true, length: { minimum: 8 }

  # Must have genre
  validates :genre, presence: true

  # Must have postal code, must be numbers, exact length is 6
  validates :postal_code, presence: true
  validates :postal_code, length: { is: 6}
  # validates :postal_code, numericality: { equal_to: 6 }
end
