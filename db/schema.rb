# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2021_12_22_023156) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "addresses", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.string "street1"
    t.string "city"
    t.string "province"
    t.integer "postal_code"
    t.string "contry_code"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "import_details", force: :cascade do |t|
    t.uuid "uuid"
    t.integer "row"
    t.text "error"
    t.integer "status"
    t.text "data"
    t.text "headers"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "orders", force: :cascade do |t|
    t.string "reference"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "import_detail_id"
    t.index ["import_detail_id"], name: "index_orders_on_import_detail_id"
  end

  create_table "parcels", force: :cascade do |t|
    t.decimal "lenght", precision: 10
    t.decimal "width", precision: 10
    t.decimal "height", precision: 10
    t.string "dimension_unit"
    t.decimal "weight", precision: 10
    t.string "weight_unit"
    t.bigint "shipment_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["shipment_id"], name: "index_parcels_on_shipment_id"
  end

  create_table "shipments", force: :cascade do |t|
    t.bigint "order_id"
    t.bigint "address_from_id"
    t.bigint "address_to_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["address_from_id"], name: "index_shipments_on_address_from_id"
    t.index ["address_to_id"], name: "index_shipments_on_address_to_id"
    t.index ["order_id"], name: "index_shipments_on_order_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "username"
    t.string "email"
    t.string "password_digest"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["username"], name: "index_users_on_username", unique: true
  end

end
