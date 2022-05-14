class Offer < ApplicationRecord
  belongs_to :user
  belongs_to :tag
  has_many :bookings
end
