class SentenceSet < ApplicationRecord
  has_many :sentences, -> { order :position }, dependent: :destroy

  validates :english_name, :polish_name, presence: true
  validates :english_name, :polish_name, uniqueness: true

  scope :active, -> { where(active: true) }
end
