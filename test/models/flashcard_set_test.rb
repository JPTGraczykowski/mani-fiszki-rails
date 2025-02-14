require "test_helper"

class FlashcardSetTest < ActiveSupport::TestCase
  test "should have many flashcards" do
    assert_equal :has_many, FlashcardSet.reflect_on_association(:flashcards).macro
  end

  test "should validate presence of English and Polish name" do
    flashcard_set = FlashcardSet.new
    assert_not flashcard_set.valid?
    assert_includes flashcard_set.errors[:english_name], "can't be blank"
    assert_includes flashcard_set.errors[:polish_name], "can't be blank"
  end

  test "should validate uniqueness of English and Polish name" do
    new_flashcard_set = FlashcardSet.new(
      english_name: flashcard_sets(:numbers).english_name,
      polish_name: flashcard_sets(:numbers).polish_name
    )
    assert_not new_flashcard_set.valid?
    assert_includes new_flashcard_set.errors[:english_name], "has already been taken"
    assert_includes new_flashcard_set.errors[:polish_name], "has already been taken"
  end
end
