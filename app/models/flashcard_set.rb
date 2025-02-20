class FlashcardSet < ApplicationRecord
  has_many :flashcards, -> { order(position: :asc) }, dependent: :destroy

  validates :english_name, :polish_name, presence: true
  validates :english_name, :polish_name, uniqueness: true
end
