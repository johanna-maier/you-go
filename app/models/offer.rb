class Offer < ApplicationRecord
  belongs_to :user, optional: true
  belongs_to :tag
  has_many :bookings

  validates :title, presence: true
  validates :description, presence: true
  validates :address, presence: true, length: { minimum: 6 }
  validates :price_per_person, numericality: { only_integer: true, greater_than: 0 }
  validates :capacity, numericality: { only_integer: true, greater_than: 0 }
  validates :offer_date, presence: true
  validates :offer_time, presence: true
end
