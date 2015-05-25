# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20150525161648) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "pg_trgm"

  create_table "posts", force: :cascade do |t|
    t.string   "title"
    t.text     "body"
    t.float    "rate",       default: 0.0
    t.integer  "evaluated",  default: 0
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
  end

  create_table "posts_words", id: false, force: :cascade do |t|
    t.integer  "word_id"
    t.integer  "post_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "posts_words", ["post_id"], name: "index_posts_words_on_post_id", using: :btree
  add_index "posts_words", ["word_id"], name: "index_posts_words_on_word_id", using: :btree

  create_table "words", force: :cascade do |t|
    t.string   "content"
    t.boolean  "kind"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "words", ["content"], name: "name_similarity_idx", using: :gist

  add_foreign_key "posts_words", "posts"
  add_foreign_key "posts_words", "words"
end
