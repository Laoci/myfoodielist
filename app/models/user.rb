class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # Must have username
  # validates :username, presence: true

  # Associations
  has_many :lists, dependent: :destroy
  has_many :restaurant_lists, through: :lists
  has_many :restaurants, through: :restaurant_lists
  has_many :reviews, dependent: :destroy
  has_many :favorites, dependent: :destroy
end
