class CreateSentences < ActiveRecord::Migration[8.1]
  def change
    create_table :sentences do |t|
      t.references :sentence_set, null: false
      t.integer :position
      t.timestamps
    end
  end
end
