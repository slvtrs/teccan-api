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

ActiveRecord::Schema.define(version: 20180529220152) do

  create_table "devices", force: :cascade do |t|
    t.string "token"
    t.integer "user_id"
    t.string "device_type"
    t.string "device_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["user_id"], name: "index_devices_on_user_id"
  end

  create_table "items", force: :cascade do |t|
    t.string "title"
    t.string "description"
    t.string "image"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "longitude"
    t.string "latitude"
  end

  create_table "offerings", force: :cascade do |t|
    t.boolean "active", default: true
    t.integer "shrine_id"
    t.integer "item_id"
    t.integer "possession_id"
    t.string "message"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["item_id"], name: "index_offerings_on_item_id"
    t.index ["possession_id"], name: "index_offerings_on_possession_id"
    t.index ["shrine_id"], name: "index_offerings_on_shrine_id"
  end

  create_table "possessions", force: :cascade do |t|
    t.boolean "active", default: true
    t.integer "user_id"
    t.integer "item_id"
    t.string "message"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string "longitude_1"
    t.string "longitude_2"
    t.string "latitude_1"
    t.string "latitude_2"
    t.integer "shrine_id"
    t.index ["item_id"], name: "index_possessions_on_item_id"
    t.index ["shrine_id"], name: "index_possessions_on_shrine_id"
    t.index ["user_id"], name: "index_possessions_on_user_id"
  end

  create_table "shrines", force: :cascade do |t|
    t.string "title"
    t.string "description"
    t.string "image"
    t.string "latitude"
    t.string "longitude"
    t.integer "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_shrines_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "username"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["username"], name: "index_users_on_username", unique: true
  end

end
