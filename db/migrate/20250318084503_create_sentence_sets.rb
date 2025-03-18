class CreateSentenceSets < ActiveRecord::Migration[8.1]
  def change
    create_table :sentence_sets do |t|
      t.string :english_name, null: false, index: true
      t.string :polish_name, null: false, index: true
      t.boolean :active, null: false, default: true
      t.index :english_name, unique: true, name: "index_sentence_sets_on_unique_english_name"
      t.index :polish_name, unique: true, name: "index_sentence_sets_on_unique_polish_name"
      t.timestamps
    end
  end
end
