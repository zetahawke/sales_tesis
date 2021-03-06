# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2020_12_26_214900) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "acceptance_criteria", force: :cascade do |t|
    t.string "name"
    t.string "criteria"
    t.string "criteria_value"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "hit_value", default: 0
  end

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.bigint "byte_size", null: false
    t.string "checksum", null: false
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "answers", force: :cascade do |t|
    t.bigint "customer_id", null: false
    t.bigint "question_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "satisfaction_questionary_id", null: false
    t.integer "acceptance_criterium_id", null: false
    t.index ["customer_id"], name: "index_answers_on_customer_id"
    t.index ["question_id"], name: "index_answers_on_question_id"
  end

  create_table "appointments", force: :cascade do |t|
    t.datetime "start_at", default: "2020-12-29 17:18:49"
    t.datetime "ends_at", default: "2021-01-02 17:18:49"
    t.datetime "appointed_at", default: "2020-12-30 17:18:49"
    t.datetime "realized_at"
    t.boolean "accomplished", default: false
    t.bigint "visit_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["visit_id"], name: "index_appointments_on_visit_id"
  end

  create_table "categories", force: :cascade do |t|
    t.string "name"
    t.string "description"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "customers", force: :cascade do |t|
    t.string "name"
    t.string "dni"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "email"
    t.string "private_token"
    t.string "phone"
    t.boolean "archived", default: false
  end

  create_table "excuses", force: :cascade do |t|
    t.string "reason"
    t.boolean "valid_argument", default: false
    t.bigint "visit_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["visit_id"], name: "index_excuses_on_visit_id"
  end

  create_table "goals", force: :cascade do |t|
    t.bigint "salesman_id", null: false
    t.string "type_of_criteria"
    t.string "criteria"
    t.string "criteria_value"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["salesman_id"], name: "index_goals_on_salesman_id"
  end

  create_table "money_goals", force: :cascade do |t|
    t.integer "amount"
    t.bigint "salesman_id", null: false
    t.string "type_of_criteria"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["salesman_id"], name: "index_money_goals_on_salesman_id"
  end

  create_table "product_tags", force: :cascade do |t|
    t.bigint "product_id", null: false
    t.bigint "tag_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["product_id"], name: "index_product_tags_on_product_id"
    t.index ["tag_id"], name: "index_product_tags_on_tag_id"
  end

  create_table "products", force: :cascade do |t|
    t.string "name"
    t.string "description"
    t.integer "price"
    t.integer "minimum_price"
    t.integer "minimum_quantity"
    t.string "facebook_link"
    t.string "instagram_link"
    t.bigint "category_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "sku"
    t.index ["category_id"], name: "index_products_on_category_id"
  end

  create_table "questions", force: :cascade do |t|
    t.string "name"
    t.string "description"
    t.integer "acceptance_criterias", array: true
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "routes", force: :cascade do |t|
    t.bigint "salesman_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["salesman_id"], name: "index_routes_on_salesman_id"
  end

  create_table "salesmen", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "email"
    t.string "private_token"
  end

  create_table "satisfaction_questionaries", force: :cascade do |t|
    t.bigint "visit_id", null: false
    t.integer "questions", array: true
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "public_token"
    t.index ["visit_id"], name: "index_satisfaction_questionaries_on_visit_id"
  end

  create_table "stocks", force: :cascade do |t|
    t.integer "amount"
    t.bigint "product_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["product_id"], name: "index_stocks_on_product_id"
  end

  create_table "tags", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "visits", force: :cascade do |t|
    t.bigint "customer_id", null: false
    t.bigint "route_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "status", default: 0
    t.float "sale_amount", default: 0.0
    t.float "original_sale_amount", default: 0.0
    t.index ["customer_id"], name: "index_visits_on_customer_id"
    t.index ["route_id"], name: "index_visits_on_route_id"
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "answers", "customers"
  add_foreign_key "answers", "questions"
  add_foreign_key "appointments", "visits"
  add_foreign_key "excuses", "visits"
  add_foreign_key "goals", "salesmen"
  add_foreign_key "money_goals", "salesmen"
  add_foreign_key "product_tags", "products"
  add_foreign_key "product_tags", "tags"
  add_foreign_key "products", "categories"
  add_foreign_key "routes", "salesmen"
  add_foreign_key "satisfaction_questionaries", "visits"
  add_foreign_key "stocks", "products"
  add_foreign_key "visits", "customers"
  add_foreign_key "visits", "routes"
end
