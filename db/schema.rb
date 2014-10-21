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

ActiveRecord::Schema.define(version: 20141021165539) do

  create_table "attendance_entries", force: true do |t|
    t.string   "first_name"
    t.string   "nickname"
    t.string   "last_name"
    t.integer  "upi"
    t.string   "netid"
    t.string   "email"
    t.string   "college_name"
    t.string   "college_abbreviation"
    t.integer  "class_year"
    t.string   "school"
    t.string   "telephone"
    t.string   "address"
    t.integer  "event_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "checked_in",           default: false
    t.string   "organization"
    t.string   "curriculum"
  end

  create_table "events", force: true do |t|
    t.string   "title"
    t.string   "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "events_users", force: true do |t|
    t.integer "event_id", null: false
    t.integer "user_id",  null: false
  end

  create_table "sessions", force: true do |t|
    t.string   "session_id", null: false
    t.string   "cas_ticket"
    t.text     "data"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "sessions", ["cas_ticket"], name: "index_sessions_on_cas_ticket"
  add_index "sessions", ["session_id"], name: "index_sessions_on_session_id"
  add_index "sessions", ["updated_at"], name: "index_sessions_on_updated_at"

  create_table "users", force: true do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "netid"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "nickname"
    t.string   "email"
  end

end
