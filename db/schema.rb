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

ActiveRecord::Schema[7.1].define(version: 2024_06_11_150700) do
  create_table "games", force: :cascade do |t|
    t.integer "player1_id"
    t.integer "player2_id"
    t.integer "player1_hits"
    t.integer "player2_hits"
    t.string "result"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["player1_id"], name: "index_games_on_player1_id"
    t.index ["player2_id"], name: "index_games_on_player2_id"
  end

  create_table "grids", force: :cascade do |t|
    t.integer "size"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "players", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "ships", force: :cascade do |t|
    t.integer "x"
    t.integer "y"
    t.integer "player_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["player_id"], name: "index_ships_on_player_id"
  end

  add_foreign_key "games", "players", column: "player1_id"
  add_foreign_key "games", "players", column: "player2_id"
  add_foreign_key "ships", "players"
end
