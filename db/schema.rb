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

ActiveRecord::Schema.define(version: 20160924063811) do

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

  create_table "railway_stations", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "name",       null: false
  end

  create_table "railway_stations_routes", force: :cascade do |t|
    t.integer "route_id",                       null: false
    t.integer "railway_station_id",             null: false
    t.integer "order_value",        default: 1
    t.integer "position",           default: 1
  end

  create_table "routes", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "tickets", force: :cascade do |t|
    t.integer  "train_id",          null: false
    t.integer  "user_id",           null: false
    t.integer  "start_station_id",  null: false
    t.integer  "finish_station_id", null: false
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
  end

  create_table "trains", force: :cascade do |t|
    t.string   "number"
    t.datetime "created_at",                        null: false
    t.datetime "updated_at",                        null: false
    t.integer  "route_id"
    t.integer  "current_station_id"
    t.boolean  "position_from_head", default: true, null: false
  end

  create_table "users", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
