require "test_helper"

class SentenceServices::SaveTest < ActiveSupport::TestCase
  test "successfully saves a sentence with words and a missing word" do
    sentence_set = SentenceSet.create!(english_name: "Test Set", polish_name: "Zestaw Testowy")
    sentence = Sentence.create!(sentence_set: sentence_set)
    params = {
      sentence_text: "This is a test sentence",
      missing_word: "test",
      fake_words_text: "fake wrong",
      polish_translation: "To jest zdanie testowe"
    }

    service = SentenceServices::Save.new(sentence: sentence, sentence_params: params)
    service.call

    # Check if the service was succeeded
    assert service.succeeded
    assert_nil service.error_message

    # Check if sentence was updated correctly
    sentence.reload
    assert_equal "This is a test sentence", sentence.to_s
    assert_equal 5, sentence.words.count
    assert_equal "To jest zdanie testowe", sentence.polish_translation

    # Check if missing word was set correctly
    missing_word = sentence.missing_word
    assert_not_nil missing_word
    assert_equal "test", missing_word.value

    # Check if fake words were created
    assert_equal 2, sentence.fake_words.count
    fake_word_values = sentence.fake_words.pluck(:value)
    assert_includes fake_word_values, "fake"
    assert_includes fake_word_values, "wrong"
  end

  test "fails when sentence text is empty" do
    sentence_set = SentenceSet.create!(english_name: "Test Set", polish_name: "Zestaw Testowy")
    sentence = Sentence.create!(sentence_set: sentence_set)
    params = {
      sentence_text: "",
      missing_word: "test",
      fake_words_text: "fake distractor wrong",
      polish_translation: "To jest zdanie testowe"
    }

    service = SentenceServices::Save.new(sentence: sentence, sentence_params: params)
    service.call

    assert_not service.succeeded
    assert_equal "Tekst zdania jest pusty.", service.error_message
  end

  test "fails when missing word is not in the sentence" do
    sentence_set = SentenceSet.create!(english_name: "Test Set", polish_name: "Zestaw Testowy")
    sentence = Sentence.create!(sentence_set: sentence_set)
    params = {
      sentence_text: "This is a sentence",
      missing_word: "test", # Not in the sentence
      fake_words_text: "fake distractor wrong",
      polish_translation: "To jest zdanie testowe"
    }

    service = SentenceServices::Save.new(sentence: sentence, sentence_params: params)
    service.call

    assert_not service.succeeded
    assert_equal "Nie podano brakującego słowa.", service.error_message
  end

  test "fails when fake words text is empty" do
    sentence_set = SentenceSet.create!(english_name: "Test Set", polish_name: "Zestaw Testowy")
    sentence = Sentence.create!(sentence_set: sentence_set)
    params = {
      sentence_text: "This is a test sentence",
      missing_word: "test",
      fake_words_text: "",
      polish_translation: "To jest zdanie testowe"
    }

    service = SentenceServices::Save.new(sentence: sentence, sentence_params: params)
    service.call

    assert_not service.succeeded
    assert_equal "Nie podano nieprawdziwych słów.", service.error_message
  end

  test "fails when a fake word exists in the sentence" do
    sentence_set = SentenceSet.create!(english_name: "Test Set", polish_name: "Zestaw Testowy")
    sentence = Sentence.create!(sentence_set: sentence_set)
    params = {
      sentence_text: "This is a test sentence",
      missing_word: "test",
      fake_words_text: "fake test wrong", # "test" is in the sentence
      polish_translation: "To jest zdanie testowe"
    }

    service = SentenceServices::Save.new(sentence: sentence, sentence_params: params)
    service.call

    assert_not service.succeeded
    assert_equal "Nieprawdziwe słowa istnieją w zdaniu.", service.error_message
  end

  test "replaces existing words and fake words" do
    sentence_set = SentenceSet.create!(english_name: "Test Set", polish_name: "Zestaw Testowy")
    sentence = Sentence.create!(sentence_set: sentence_set)
    Word.create!(sentence: sentence, value: "Original", position: 1)
    Word.create!(sentence: sentence, value: "words", position: 2, missing: true)
    FakeWord.create!(sentence: sentence, value: "initial_fake")
    sentence.reload

    assert_equal 2, sentence.words.count
    assert_equal 1, sentence.fake_words.count

    params = {
      sentence_text: "New test sentence",
      missing_word: "sentence",
      fake_words_text: "different fake words",
      polish_translation: "Nowe zdanie testowe"
    }

    service = SentenceServices::Save.new(sentence: sentence, sentence_params: params)
    service.call

    assert service.succeeded

    # Check if old words and fake words were replaced
    sentence.reload
    assert_equal 3, sentence.words.count
    assert_equal 3, sentence.fake_words.count
    assert_equal "New test sentence", sentence.to_s
    assert_equal "sentence", sentence.missing_word.value
  end
end
