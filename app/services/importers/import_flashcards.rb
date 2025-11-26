module Importers
  class ImportFlashcards
    attr_reader :flashcard_set, :flashcards_data, :start_index

    def initialize(flashcard_set_id:, flashcards_data:, start_index: 1)
      begin
        @flashcard_set = FlashcardSet.find(flashcard_set_id)
        @flashcards_data = flashcards_data
        @start_index = start_index
      rescue ActiveRecord::RecordNotFound
        raise "Flashcard set not found"
      end
    end

    def call
      ActiveRecord::Base.transaction do
        flashcards_data.each.with_index(start_index) do |flashcard_data, index|
          next if invalid_flashcard_data?(flashcard_data)

          flashcard_set.flashcards.find_or_create_by!(
            english_name: flashcard_data[:english_name],
            polish_name: flashcard_data[:polish_name],
            position: index
          )
        end
      end
    rescue => e
      raise "Failed to import flashcards: #{e.message}"
    end

    private

    def invalid_flashcard_data?(flashcard_data)
      flashcard_data[:english_name].blank? || flashcard_data[:polish_name].blank?
    end
  end
end
