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

  create_table "attendance_entries", force: :cascade do |t|
    t.string   "first_name",           limit: 255
    t.string   "nickname",             limit: 255
    t.string   "last_name",            limit: 255
    t.integer  "upi",                  limit: 4
    t.string   "netid",                limit: 255
    t.string   "email",                limit: 255
    t.string   "college_name",         limit: 255
    t.string   "college_abbreviation", limit: 255
    t.integer  "class_year",           limit: 4
    t.string   "school",               limit: 255
    t.string   "telephone",            limit: 255
    t.string   "address",              limit: 255
    t.integer  "event_id",             limit: 4
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "organization",         limit: 255
    t.string   "curriculum",           limit: 255
  end

  create_table "events", force: :cascade do |t|
    t.string   "title",       limit: 255
    t.string   "description", limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "events_users", force: :cascade do |t|
    t.integer "event_id", limit: 4, null: false
    t.integer "user_id",  limit: 4, null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "first_name", limit: 255
    t.string   "last_name",  limit: 255
    t.string   "netid",      limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "nickname",   limit: 255
    t.string   "email",      limit: 255
  end

end
