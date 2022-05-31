class Tag < ApplicationRecord
  has_many :offers, dependent: :destroy
  has_one_attached :photo
end
