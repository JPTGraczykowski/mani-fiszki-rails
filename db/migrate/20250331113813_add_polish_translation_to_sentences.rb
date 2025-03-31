class AddPolishTranslationToSentences < ActiveRecord::Migration[8.1]
  def change
    add_column :sentences, :polish_translation, :text, default: ""
  end
end
