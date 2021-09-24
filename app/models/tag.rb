class Tag < ApplicationRecord
  belongs_to :user
  belongs_to :restaurant

  validates :name, presence: true
end
