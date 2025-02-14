class Flashcard < ApplicationRecord
  belongs_to :flashcard_set, required: true

  acts_as_list scope: :flashcard_set

  validates :english_name, :polish_name, presence: true
  validates :english_name, :polish_name, uniqueness: { scope: :flashcard_set_id }
end
