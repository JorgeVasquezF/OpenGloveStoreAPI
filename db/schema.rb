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

ActiveRecord::Schema.define(version: 2020_06_29_081932) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "apps", force: :cascade do |t|
    t.string "name"
    t.string "description"
    t.string "git_url"
    t.string "video_url"
    t.string "documentation"
    t.boolean "published", default: false
    t.string "image_url"
    t.integer "verified", default: 0
    t.string "last_release"
    t.string "os"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "apps_tags", id: false, force: :cascade do |t|
    t.bigint "app_id", null: false
    t.bigint "tag_id", null: false
    t.index ["app_id", "tag_id"], name: "index_apps_tags_on_app_id_and_tag_id"
    t.index ["tag_id", "app_id"], name: "index_apps_tags_on_tag_id_and_app_id"
  end

  create_table "checks", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "app_id"
    t.integer "role"
    t.boolean "approved", default: false
    t.boolean "disapproved", default: false
    t.string "comment"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["app_id"], name: "index_checks_on_app_id"
    t.index ["user_id"], name: "index_checks_on_user_id"
  end

  create_table "ratings", force: :cascade do |t|
    t.float "rating"
    t.string "ip"
    t.string "comment"
    t.date "date"
    t.bigint "app_id"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["app_id"], name: "index_ratings_on_app_id"
    t.index ["user_id"], name: "index_ratings_on_user_id"
  end

  create_table "tags", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "username", null: false
    t.string "email", null: false
    t.string "password_digest", null: false
    t.integer "role", default: 2
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.boolean "email_confirmed", default: false
    t.string "confirm_token"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["username"], name: "index_users_on_username", unique: true
  end

end
