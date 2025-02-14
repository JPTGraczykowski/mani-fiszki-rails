require "test_helper"

class FlashcardTest < ActiveSupport::TestCase
  test "should belongs to flashcard_set" do
    assert_equal :belongs_to, Flashcard.reflect_on_association(:flashcard_set).macro
  end

  test "should validate presence of English and Polish name" do
    flashcard = Flashcard.new
    assert_not flashcard.valid?
    assert_includes flashcard.errors[:english_name], "can't be blank"
    assert_includes flashcard.errors[:polish_name], "can't be blank"
  end

  test "should validate uniqueness of English and Polish name" do
    new_flashcard = Flashcard.new(
      flashcard_set: flashcard_sets(:numbers),
      english_name: flashcards(:one).english_name,
      polish_name: flashcards(:one).polish_name
    )
    assert_not new_flashcard.valid?
    assert_includes new_flashcard.errors[:english_name], "has already been taken"
    assert_includes new_flashcard.errors[:polish_name], "has already been taken"
  end
end
