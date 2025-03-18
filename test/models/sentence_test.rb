require "test_helper"

class SentenceTest < ActiveSupport::TestCase
  test "should belongs to sentence_set" do
    assert_equal :belongs_to, Sentence.reflect_on_association(:sentence_set).macro
  end

  test "should have many words and fake words" do
    assert_equal :has_many, Sentence.reflect_on_association(:words).macro
    assert_equal :has_many, Sentence.reflect_on_association(:fake_words).macro
  end
end
