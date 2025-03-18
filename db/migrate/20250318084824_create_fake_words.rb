class CreateFakeWords < ActiveRecord::Migration[8.1]
  def change
    create_table :fake_words do |t|
      t.references :sentence, null: false
      t.string :value, null: false, index: true
      t.timestamps
    end
  end
end
