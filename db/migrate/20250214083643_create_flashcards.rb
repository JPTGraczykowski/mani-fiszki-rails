class CreateFlashcards < ActiveRecord::Migration[8.1]
  def change
    create_table :flashcards do |t|
      t.string :english_name, null: false, index: true
      t.string :polish_name, null: false, index: true
      t.integer :position, null: false, default: 0
      t.references :flashcard_set, foreign_key: true, null: false
      t.index [:english_name, :flashcard_set_id],
              unique: true,
              name: "index_flashcards_on_english_name_and_set"
      t.index [:polish_name, :flashcard_set_id],
              unique: true,
              name: "index_flashcards_on_polish_name_and_set"

      t.timestamps
    end
  end
end
