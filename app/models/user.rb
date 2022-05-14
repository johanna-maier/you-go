class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :offers, dependent: :destroy
  has_many :reviews, dependent: :destroy
  has_many :favourites, dependent: :destroy
  has_many :bookings, dependent: :destroy

  CATEGORY = ['male', 'female'].freeze
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :gender, inclusion: { in: CATEGORY }
end
