class Booking < ApplicationRecord
  belongs_to :product
  belongs_to :user

  has_one :review, dependent: :destroy

  validates :total_price, presence: true
  validates :first_day_of_booking, presence: true
  validates :last_day_of_booking, presence: true
end
