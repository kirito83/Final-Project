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

ActiveRecord::Schema.define(version: 20180326074533) do

  create_table "categories", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "matches", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "winner1"
    t.string "winner2"
    t.string "joueur1"
    t.string "joueur2"
    t.boolean "statut", default: true
    t.integer "tournament_id"
    t.index ["tournament_id"], name: "index_matches_on_tournament_id"
  end

  create_table "order_items", force: :cascade do |t|
    t.integer "quantity", default: 0, null: false
    t.decimal "price", precision: 15, scale: 2, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "order_id"
    t.index ["order_id"], name: "index_order_items_on_order_id"
  end

  create_table "orders", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name", null: false
    t.decimal "sub_total", precision: 15, scale: 2, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "product_variants", force: :cascade do |t|
    t.string "title", null: false
    t.decimal "price", precision: 15, scale: 2, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "product_id"
    t.index ["product_id"], name: "index_product_variants_on_product_id"
  end

  create_table "products", force: :cascade do |t|
    t.string "title", null: false
    t.text "description"
    t.decimal "price", precision: 15, scale: 2, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text "image_url"
  end

  create_table "tournaments", force: :cascade do |t|
    t.string "title"
    t.text "description"
    t.datetime "date"
    t.integer "pricepool"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "user_id"
    t.string "winners"
    t.integer "category_id"
    t.string "place"
    t.integer "maxPlayers"
    t.string "game"
    t.string "vainqueur"
    t.index ["category_id"], name: "index_tournaments_on_category_id"
    t.index ["user_id"], name: "index_tournaments_on_user_id"
  end

  create_table "tournaments_users", id: false, force: :cascade do |t|
    t.integer "tournament_id", null: false
    t.integer "user_id", null: false
    t.index ["tournament_id", "user_id"], name: "index_tournaments_users_on_tournament_id_and_user_id"
    t.index ["user_id", "tournament_id"], name: "index_tournaments_users_on_user_id_and_tournament_id"
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
    t.string "provider"
    t.string "uid"
    t.string "username"
    t.string "street"
    t.string "city"
    t.string "country"
    t.string "photo_file_name"
    t.string "photo_content_type"
    t.integer "photo_file_size"
    t.datetime "photo_updated_at"
    t.integer "points", default: 0
    t.text "description"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

end
