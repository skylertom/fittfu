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

ActiveRecord::Schema.define(version: 20151119031742) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "uuid-ossp"

  create_table "game_stats", id: :uuid, default: "uuid_generate_v4()", force: :cascade do |t|
    t.uuid     "game_id"
    t.uuid     "player_id"
    t.integer  "ds",         default: 0
    t.integer  "turns",      default: 0
    t.integer  "goals",      default: 0
    t.integer  "assists",    default: 0
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "games", id: :uuid, default: "uuid_generate_v4()", force: :cascade do |t|
    t.integer  "time_slot"
    t.integer  "week"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "time"
  end

  create_table "invitations", id: :uuid, default: "uuid_generate_v4()", force: :cascade do |t|
    t.string   "authority"
    t.uuid     "user_id"
    t.uuid     "code"
    t.string   "email"
    t.uuid     "invitor_id"
    t.integer  "accepted",   default: 0
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "memberships", id: :uuid, default: "uuid_generate_v4()", force: :cascade do |t|
    t.uuid     "player_id"
    t.uuid     "team_id"
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
    t.boolean  "captain",    default: false
    t.boolean  "fantasy",    default: false
  end

  add_index "memberships", ["player_id"], name: "index_memberships_on_player_id", using: :btree

  create_table "players", id: :uuid, default: "uuid_generate_v4()", force: :cascade do |t|
    t.string   "name"
    t.integer  "gender"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "schedules", id: :uuid, default: "uuid_generate_v4()", force: :cascade do |t|
    t.datetime "start_time"
    t.datetime "end_time"
    t.integer  "year"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "team_games", id: :uuid, default: "uuid_generate_v4()", force: :cascade do |t|
    t.uuid     "team_id"
    t.uuid     "game_id"
    t.integer  "points",     default: 0
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  add_index "team_games", ["team_id"], name: "index_team_games_on_team_id", using: :btree

  create_table "teams", id: :uuid, default: "uuid_generate_v4()", force: :cascade do |t|
    t.string   "name"
    t.string   "color"
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
    t.boolean  "fantasy",    default: false
  end

  create_table "users", id: :uuid, default: "uuid_generate_v4()", force: :cascade do |t|
    t.string   "email",                  default: "",    null: false
    t.string   "encrypted_password",     default: "",    null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.datetime "created_at",                             null: false
    t.datetime "updated_at",                             null: false
    t.string   "name"
    t.boolean  "admin",                  default: false
    t.boolean  "commissioner",           default: false
    t.uuid     "invite_code"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

end
