class Offer < ApplicationRecord
  belongs_to :user, optional: true
  belongs_to :tag, optional: true # TODO: allow null reference in schema
  has_many :bookings
  has_many :reviews, dependent: :destroy
  has_many_attached :photos


  validates :title, presence: true
  validates :description, presence: true
  validates :address, presence: true, length: { minimum: 1 } # Meetup data had address with 4 letters
  validates :price_per_person, numericality: { only_integer: true}, allow_nil: true
  validates :capacity, numericality: { only_integer: true, greater_than_or_equal_to: 0 }, allow_nil: true
  validates :offer_date, presence: true
  validates :offer_time, presence: true

  geocoded_by :address
  after_validation :geocode, if: :will_save_change_to_address?

  include PgSearch::Model
  pg_search_scope :global_search,
    against: [ :title, :description ],
    associated_against: {
      tag: [ :name, :category ]
    },
    using: {
        tsearch: { prefix: true }
    }

  def avg_rating
    reviews.average(:rating)
  end
end
