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

ActiveRecord::Schema.define(version: 20180928035121) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "sand_boxes", force: :cascade do |t|
    t.string "title"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "scrapes", force: :cascade do |t|
    t.text "scrape_content", null: false
    t.bigint "webscraper_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["webscraper_id"], name: "index_scrapes_on_webscraper_id"
  end

  create_table "user_webscrapers", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "webscraper_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_user_webscrapers_on_user_id"
    t.index ["webscraper_id"], name: "index_user_webscrapers_on_webscraper_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "username", null: false
    t.string "email", null: false
    t.string "encrypted_password", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet "current_sign_in_ip"
    t.inet "last_sign_in_ip"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "webscrapers", force: :cascade do |t|
    t.string "name", null: false
    t.text "content"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id"
    t.index ["user_id"], name: "index_webscrapers_on_user_id"
  end

  add_foreign_key "scrapes", "webscrapers"
  add_foreign_key "user_webscrapers", "users"
  add_foreign_key "user_webscrapers", "webscrapers"
  add_foreign_key "webscrapers", "users"
end
