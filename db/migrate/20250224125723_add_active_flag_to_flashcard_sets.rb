class AddActiveFlagToFlashcardSets < ActiveRecord::Migration[8.1]
  def change
    add_column :flashcard_sets, :active, :boolean, null: false, default: true
  end
end
