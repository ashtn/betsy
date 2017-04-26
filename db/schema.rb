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

ActiveRecord::Schema.define(version: 20170426012917) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "categories", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "categories_items", force: :cascade do |t|
    t.integer  "category_id"
    t.integer  "item_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.index ["category_id"], name: "index_categories_items_on_category_id", using: :btree
    t.index ["item_id"], name: "index_categories_items_on_item_id", using: :btree
  end

  create_table "items", force: :cascade do |t|
    t.integer  "merchant_id"
    t.string   "name"
    t.string   "description"
    t.float    "price"
    t.integer  "inventory"
    t.string   "photo"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "merchants", force: :cascade do |t|
    t.string   "username"
    t.string   "email"
    t.integer  "uid",        null: false
    t.string   "provider",   null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "order_items", force: :cascade do |t|
    t.integer  "item_id"
    t.integer  "order_id"
    t.integer  "quantity"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.integer  "merchant_id"
  end

  create_table "orders", force: :cascade do |t|
    t.integer  "session_id"
    t.string   "status"
    t.float    "total"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "payments", force: :cascade do |t|
    t.string   "name_on_card"
    t.string   "email"
    t.string   "phone_num"
    t.string   "ship_address"
    t.string   "bill_address"
    t.string   "card_number"
    t.string   "expiration_date"
    t.string   "CCV"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.integer  "order_id"
  end

  create_table "reviews", force: :cascade do |t|
    t.string   "description"
    t.integer  "rating"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.integer  "item_id"
    t.index ["item_id"], name: "index_reviews_on_item_id", using: :btree
  end

  add_foreign_key "reviews", "items"
end
