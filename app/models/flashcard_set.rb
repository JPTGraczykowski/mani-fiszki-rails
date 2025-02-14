class FlashcardSet < ApplicationRecord
  validates :english_name, :polish_name, presence: true
  validates :english_name, :polish_name, uniqueness: true
end
