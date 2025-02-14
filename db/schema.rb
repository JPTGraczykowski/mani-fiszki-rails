# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[8.1].define(version: 2025_02_14_083643) do
  create_table "flashcard_sets", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "english_name", null: false
    t.string "polish_name", null: false
    t.datetime "updated_at", null: false
    t.index ["english_name"], name: "index_flashcard_sets_on_english_name"
    t.index ["english_name"], name: "index_flashcard_sets_on_unique_english_name", unique: true
    t.index ["polish_name"], name: "index_flashcard_sets_on_polish_name"
    t.index ["polish_name"], name: "index_flashcard_sets_on_unique_polish_name", unique: true
  end

  create_table "flashcards", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "english_name", null: false
    t.integer "flashcard_set_id", null: false
    t.string "polish_name", null: false
    t.integer "position", default: 0, null: false
    t.datetime "updated_at", null: false
    t.index ["english_name", "flashcard_set_id"], name: "index_flashcards_on_english_name_and_set", unique: true
    t.index ["english_name"], name: "index_flashcards_on_english_name"
    t.index ["flashcard_set_id"], name: "index_flashcards_on_flashcard_set_id"
    t.index ["polish_name", "flashcard_set_id"], name: "index_flashcards_on_polish_name_and_set", unique: true
    t.index ["polish_name"], name: "index_flashcards_on_polish_name"
  end

  add_foreign_key "flashcards", "flashcard_sets"
end
