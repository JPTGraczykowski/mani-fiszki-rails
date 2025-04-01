class SentenceServices::Save
  attr_accessor :sentence,
                :succeeded,
                :error_message

  def initialize(sentence:, sentence_params:)
    @sentence = sentence
    @sentence_params = sentence_params
    @succeeded = true
  end

  def call
    ActiveRecord::Base.transaction do
      sentence.polish_translation = sentence_params[:polish_translation]
      sentence.save!

      clear_words_from_sentence
      clear_fake_words_from_sentence

      sentence.reload

      assign_words_to_sentence
      choose_the_missing_word
      assign_fake_words_to_sentence
    end
  rescue => e
    @succeeded = false
    @error_message = e.message
  end

  private

  attr_accessor :sentence_params

  def clear_words_from_sentence
    sentence.words.delete_all
  end

  def clear_fake_words_from_sentence
    sentence.fake_words.delete_all
  end

  def assign_words_to_sentence
    words_to_assign = sentence_params[:sentence_text].split(" ")

    if words_to_assign.empty?
      raise "Tekst zdania jest pusty."
    end

    words_to_assign.each_with_index do |word_value, index|
      Word.create!(sentence_id: sentence.id, value: word_value, position: index + 1)
    end
  end

  def choose_the_missing_word
    missing_word_value = sentence_params[:missing_word]

    unless sentence.words.pluck(:value).include?(missing_word_value)
      raise "Nie podano brakującego słowa."
    end

    sentence.words.find_by(value: missing_word_value).update!(missing: true)
  end

  def assign_fake_words_to_sentence
    fake_words = sentence_params[:fake_words_text].split(" ")

    if fake_words.empty?
      raise "Nie podano nieprawdziwych słów."
    end

    if (sentence.words.pluck(:value) & fake_words).any?
      raise "Nieprawdziwe słowa istnieją w zdaniu."
    end

    fake_words.each do |word_value|
      FakeWord.create!(sentence_id: sentence.id, value: word_value)
    end
  end
end
