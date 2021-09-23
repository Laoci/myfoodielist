class List < ApplicationRecord
  has_many :restaurants, through: :restaurant_lists
  belongs_to :user

  # Must have name, must be string, max 15 letters
  validates :name, presence: true, length: { maximum: 15 }
end
