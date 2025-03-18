require "test_helper"

class SentenceSetTest < ActiveSupport::TestCase
  test "should have many sentences" do
    assert_equal :has_many, SentenceSet.reflect_on_association(:sentences).macro
  end

  test "should validate presence of English and Polish name" do
    sentence_set = SentenceSet.new
    assert_not sentence_set.valid?
    assert_includes sentence_set.errors[:english_name], "can't be blank"
    assert_includes sentence_set.errors[:polish_name], "can't be blank"
  end

  test "should validate uniqueness of English and Polish name" do
    new_sentence_set = SentenceSet.new(
      english_name: sentence_sets(:hobbies).english_name,
      polish_name: sentence_sets(:hobbies).polish_name
    )
    assert_not new_sentence_set.valid?
    assert_includes new_sentence_set.errors[:english_name], "has already been taken"
    assert_includes new_sentence_set.errors[:polish_name], "has already been taken"
  end
end
