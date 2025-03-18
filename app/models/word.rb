class Word < ApplicationRecord
  belongs_to :sentence, required: true

  acts_as_list scope: :sentence

  validates :value, presence: true
end
