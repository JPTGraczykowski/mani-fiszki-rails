class CreateWords < ActiveRecord::Migration[8.1]
  def change
    create_table :words do |t|
      t.references :sentence, null: false
      t.string :value, null: false, index: true
      t.integer :position
      t.boolean :missing, default: false
      t.timestamps
    end
  end
end
