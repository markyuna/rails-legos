class Booking < ApplicationRecord
  belongs_to :user
  belongs_to :product

  has_one :review, dependent: :destroy

  validates :total_price, presence: true
  validates :first_day_of_booking, presence: true
  validates :last_day_of_booking, presence: true

  # before_save :calculate_total_price

  # private

  # def calculate_total_price
  #   self.total_price = (end_date - start_date).to_i * product.price
  # end
end
