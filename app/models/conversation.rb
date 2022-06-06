class Conversation < ApplicationRecord
  belongs_to :author, class_name: 'User'
  belongs_to :receiver, class_name: 'User'
  belongs_to :offer
  validates :author, uniqueness: { scope: :offer }

  has_many :messages, -> { order(created_at: :desc) }, dependent: :destroy

  scope :participating, ->(user) do
    where("author_id = ? OR receiver_id = ?", user.id, user.id)
  end

  scope :about, ->(sender_id, offer_id) do
    where(author_id: sender_id, offer_id: offer_id)
  end

  # scope :between, ->(sender_id, receiver_id) do
  #   where(author_id: sender_id, receiver_id: receiver_id).or(where(author_id: receiver_id, receiver_id: sender_id)).limit(1)
  # end

  def with(current_user)
    author == current_user ? receiver : author
  end

  def participates?(user)
    author == user || receiver == user
  end
end
