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

ActiveRecord::Schema.define(version: 20170703155940) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "projects", id: :serial, force: :cascade do |t|
    t.string "code"
    t.string "name"
    t.string "status"
    t.string "url"
    t.date "start_date"
    t.date "end_date"
    t.string "short"
    t.text "description"
    t.text "topics", default: [], array: true
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["code"], name: "index_projects_on_code"
  end

  create_table "sites", id: :serial, force: :cascade do |t|
    t.string "code"
    t.string "name"
    t.string "status"
    t.string "url"
    t.text "description"
    t.text "topics", default: [], array: true
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["code"], name: "index_sites_on_code"
  end

  create_table "users", id: :serial, force: :cascade do |t|
    t.uuid "uuid"
    t.string "sub"
    t.string "username"
    t.string "email"
    t.string "thumbnail"
    t.string "role"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email"
    t.index ["sub"], name: "index_users_on_sub"
    t.index ["uuid"], name: "index_users_on_uuid"
  end

end
