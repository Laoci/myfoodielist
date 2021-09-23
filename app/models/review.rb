class Review < ApplicationRecord
  belongs_to :restaurant
  belongs_to :user

  # content can be empty

  # Must have rating, must be a number, must be between 1 to 5
  validates :rating, presence: true
  validates :rating, numericality: { only_integer: true }
  validates :rating, numericality: { greater_than_or_equal_to: 1, less_than_or_equal_to: 5 }
end
