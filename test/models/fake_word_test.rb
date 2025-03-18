require "test_helper"

class FakeWordTest < ActiveSupport::TestCase
  test "should belong to sentence" do
    assert_equal :belongs_to, FakeWord.reflect_on_association(:sentence).macro
  end

  test "should validate presence of value" do
    fake_word = FakeWord.new
    assert_not fake_word.valid?
    assert_includes fake_word.errors[:value], "can't be blank"
  end
end
