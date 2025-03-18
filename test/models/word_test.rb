require "test_helper"

class WordTest < ActiveSupport::TestCase
  test "should belong to sentence" do
    assert_equal :belongs_to, Word.reflect_on_association(:sentence).macro
  end

  test "should validate presence of value" do
    word = Word.new
    assert_not word.valid?
    assert_includes word.errors[:value], "can't be blank"
  end
end
