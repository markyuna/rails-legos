class Product < ApplicationRecord
  belongs_to :user

  has_many :bookings

  has_one_attached :photo
  has_many :reviews, through: :bookings

  validates :title, presence: true
  validates :description, presence: true
  validates :address, presence: true
  validates :city, presence: true
  validates :capacity, presence: true
  validates :price, presence: true
  validates :start_date, presence: true
  validates :end_date, presence: true
end
