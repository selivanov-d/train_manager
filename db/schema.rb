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

ActiveRecord::Schema.define(version: 20161006100523) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "carriages", force: :cascade do |t|
    t.integer  "train_id"
    t.integer  "upper_seats",       default: 0, null: false
    t.integer  "bottom_seats",      default: 0, null: false
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
    t.string   "type"
    t.integer  "side_bottom_seats", default: 0
    t.integer  "side_upper_seats",  default: 0
    t.integer  "seating_seats",     default: 0
    t.integer  "position"
  end

  add_index "carriages", ["train_id"], name: "index_carriages_on_train_id", using: :btree
  add_index "carriages", ["type"], name: "index_carriages_on_type", using: :btree

  create_table "railway_stations", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "name",       null: false
  end

  create_table "railway_stations_routes", force: :cascade do |t|
    t.integer  "route_id",                       null: false
    t.integer  "railway_station_id",             null: false
    t.integer  "position",           default: 1
    t.datetime "arrival_datetime"
    t.datetime "departure_datetime"
  end

  add_index "railway_stations_routes", ["railway_station_id"], name: "index_railway_stations_routes_on_railway_station_id", using: :btree
  add_index "railway_stations_routes", ["route_id", "railway_station_id"], name: "index_route_station", unique: true, using: :btree
  add_index "railway_stations_routes", ["route_id"], name: "index_railway_stations_routes_on_route_id", using: :btree

  create_table "routes", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "tickets", force: :cascade do |t|
    t.integer  "train_id",             null: false
    t.integer  "user_id",              null: false
    t.integer  "departure_station_id", null: false
    t.integer  "arrival_station_id",   null: false
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
  end

  add_index "tickets", ["arrival_station_id"], name: "index_tickets_on_arrival_station_id", using: :btree
  add_index "tickets", ["departure_station_id"], name: "index_tickets_on_departure_station_id", using: :btree
  add_index "tickets", ["train_id"], name: "index_tickets_on_train_id", using: :btree
  add_index "tickets", ["user_id"], name: "index_tickets_on_user_id", using: :btree

  create_table "trains", force: :cascade do |t|
    t.string   "number"
    t.datetime "created_at",                        null: false
    t.datetime "updated_at",                        null: false
    t.integer  "route_id"
    t.integer  "current_station_id"
    t.boolean  "position_from_head", default: true, null: false
  end

  add_index "trains", ["current_station_id"], name: "index_trains_on_current_station_id", using: :btree
  add_index "trains", ["route_id"], name: "index_trains_on_route_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.datetime "created_at",                             null: false
    t.datetime "updated_at",                             null: false
    t.string   "first_name"
    t.string   "family_name"
    t.string   "email",                  default: "",    null: false
    t.string   "encrypted_password",     default: "",    null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.boolean  "admin",                  default: false
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["first_name", "family_name"], name: "index_users_on_first_name_and_family_name", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

end
