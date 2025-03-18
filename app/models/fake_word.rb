class FakeWord < ApplicationRecord
  belongs_to :sentence, required: true

  validates :value, presence: true
end
