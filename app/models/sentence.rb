class Sentence < ApplicationRecord
  belongs_to :sentence_set, required: true
  has_many :words, -> { order(:position) }, dependent: :destroy
  has_many :fake_words, dependent: :destroy

  acts_as_list scope: :sentence_set

  def missing_word
    words.find_by(missing: true)
  end
end
