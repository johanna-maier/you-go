class Review < ApplicationRecord
  belongs_to :offer
  belongs_to :user

  validates :rating, presence: true, inclusion: [1, 2, 3, 4, 5]
  validates :comment, presence: true
  validates :title, presence: true
end
