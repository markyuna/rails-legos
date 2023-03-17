class Booking < ApplicationRecord
  belongs_to :product
  belongs_to :user
  has_one :review, dependent: :destroy

  validates :total_price, presence: true
  validates :start_date, presence: true
  validates :end_date, presence: true
  validates :status, presence: true

  before_save :calculate_total_price

  private

  def calculate_total_price
    self.total_price = (end_date - start_date).to_i * product.price
  end
end

