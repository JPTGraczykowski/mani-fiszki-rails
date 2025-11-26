module Importers
  class ImportFlashcards
    def initialize(flashcard_set_id:, flashcards_data:)
      begin
        @flashcard_set = FlashcardSet.find(flashcard_set_id)
        @flashcards_data = flashcards_data
        @existing_english_names = retrieve_existing_names(:english_name)
        @existing_polish_names = retrieve_existing_names(:polish_name)
      rescue ActiveRecord::RecordNotFound
        raise "Flashcard set not found"
      end
    end

    def call
      ActiveRecord::Base.transaction do
        start_index = flashcard_set.flashcards.count + 1

        flashcards_data.each.with_index(start_index) do |flashcard_data, index|
          next if invalid_flashcard_data?(flashcard_data)
          next if duplicated_flashcard?(flashcard_data)

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

    attr_reader :flashcard_set, :flashcards_data, :existing_english_names, :existing_polish_names

    def retrieve_existing_names(language)
      flashcard_set.flashcards.pluck(language).map(&:downcase)
    end

    def invalid_flashcard_data?(flashcard_data)
      flashcard_data[:english_name].blank? || flashcard_data[:polish_name].blank?
    end

    def duplicated_flashcard?(flashcard_data)
      english_duplicate = existing_english_names.include?(flashcard_data[:english_name].downcase)
      polish_duplicate = existing_polish_names.include?(flashcard_data[:polish_name].downcase)
      english_duplicate || polish_duplicate
    end
  end
end
