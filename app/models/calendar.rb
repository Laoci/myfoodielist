class Calendar < ApplicationRecord
  belongs_to :user
  has_many :restaurant

  validates :user, presence: true
  validates :restaurant, presence: true
  validates :starts_at, presence: true
end
