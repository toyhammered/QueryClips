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

ActiveRecord::Schema.define(version: 20160806191722) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "database_connections", force: true do |t|
    t.string   "host"
    t.integer  "port"
    t.string   "name"
    t.string   "dbname"
    t.string   "password"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "dialect",    default: "PostgreSQL", null: false
    t.integer  "user_id",    default: 1,            null: false
    t.string   "username"
  end

  create_table "saved_queries", force: true do |t|
    t.string   "name"
    t.text     "query"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "database_connection_id", default: 1,        null: false
    t.string   "slug"
    t.integer  "user_id",                default: 1,        null: false
    t.string   "privacy",                default: "public", null: false
  end

  add_index "saved_queries", ["slug"], name: "index_saved_queries_on_slug", unique: true, using: :btree

  create_table "users", force: true do |t|
    t.string   "email"
    t.string   "password_digest"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "admin",           default: false, null: false
  end

end
