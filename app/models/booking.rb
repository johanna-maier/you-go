class Booking < ApplicationRecord
  belongs_to :offer
  belongs_to :user
  validates :participants, presence: true
end
