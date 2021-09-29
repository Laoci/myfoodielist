class Calendar < ApplicationRecord
  belongs_to :user
  belongs_to :restaurant

  validates :scheduled_date, presence: true
end
