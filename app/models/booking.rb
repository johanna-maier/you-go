class Booking < ApplicationRecord
  belongs_to :offer
  belongs_to :user
  validates :number_of_participants, numericality: { only_integer: true, greater_than_or_equal_to: 0 }, allow_nil: true
end
