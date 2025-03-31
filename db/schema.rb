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

ActiveRecord::Schema[8.1].define(version: 2025_03_31_113813) do
  create_table "fake_words", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.integer "sentence_id", null: false
    t.datetime "updated_at", null: false
    t.string "value", null: false
    t.index ["sentence_id"], name: "index_fake_words_on_sentence_id"
    t.index ["value"], name: "index_fake_words_on_value"
  end

  create_table "flashcard_sets", force: :cascade do |t|
    t.boolean "active", default: true, null: false
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

  create_table "sentence_sets", force: :cascade do |t|
    t.boolean "active", default: true, null: false
    t.datetime "created_at", null: false
    t.string "english_name", null: false
    t.string "polish_name", null: false
    t.datetime "updated_at", null: false
    t.index ["english_name"], name: "index_sentence_sets_on_english_name"
    t.index ["english_name"], name: "index_sentence_sets_on_unique_english_name", unique: true
    t.index ["polish_name"], name: "index_sentence_sets_on_polish_name"
    t.index ["polish_name"], name: "index_sentence_sets_on_unique_polish_name", unique: true
  end

  create_table "sentences", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.text "polish_translation", default: ""
    t.integer "position"
    t.integer "sentence_set_id", null: false
    t.datetime "updated_at", null: false
    t.index ["sentence_set_id"], name: "index_sentences_on_sentence_set_id"
  end

  create_table "sessions", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "ip_address"
    t.datetime "updated_at", null: false
    t.string "user_agent"
    t.integer "user_id", null: false
    t.index ["user_id"], name: "index_sessions_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "email", null: false
    t.string "password_digest", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
  end

  create_table "words", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.boolean "missing", default: false
    t.integer "position"
    t.integer "sentence_id", null: false
    t.datetime "updated_at", null: false
    t.string "value", null: false
    t.index ["sentence_id"], name: "index_words_on_sentence_id"
    t.index ["value"], name: "index_words_on_value"
  end

  add_foreign_key "flashcards", "flashcard_sets"
  add_foreign_key "sessions", "users"
end
