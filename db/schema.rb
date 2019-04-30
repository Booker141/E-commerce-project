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

ActiveRecord::Schema.define(version: 20190426101122) do

  create_table "cart_items", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.bigint "liquor_id"
    t.bigint "cart_id"
    t.float "price", limit: 24
    t.integer "amount"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "carts", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "liquors", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.string "name", null: false
    t.bigint "producer_id", null: false
    t.datetime "produced_at"
    t.text "blurb"
    t.integer "graduation"
    t.float "price", limit: 24
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "cover_image_file_name"
    t.string "cover_image_content_type"
    t.integer "cover_image_file_size"
    t.datetime "cover_image_updated_at"
    t.index ["producer_id"], name: "fk_liquors_producers"
  end

  create_table "liquors_suppliers", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.bigint "liquor_id", null: false
    t.bigint "supplier_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["liquor_id"], name: "fk_liquors_suppliers_liquors"
    t.index ["supplier_id"], name: "fk_liquors_suppliers_suppliers"
  end

  create_table "order_items", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.bigint "liquor_id"
    t.bigint "order_id"
    t.float "price", limit: 24
    t.integer "amount"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["order_id"], name: "fk_order_items_orders"
  end

  create_table "orders", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.string "email"
    t.string "phone_number"
    t.string "ship_to_first_name"
    t.string "ship_to_last_name"
    t.string "ship_to_address"
    t.string "ship_to_city"
    t.string "ship_to_postal_code"
    t.string "ship_to_country_code"
    t.string "customer_ip"
    t.string "status"
    t.string "error_message"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "producers", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "suppliers", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.string "first_name", null: false
    t.string "last_name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "liquors", "producers", name: "fk_liquors_producers", on_delete: :cascade
  add_foreign_key "liquors_suppliers", "liquors", name: "fk_liquors_suppliers_liquors", on_delete: :cascade
  add_foreign_key "liquors_suppliers", "suppliers", name: "fk_liquors_suppliers_suppliers", on_delete: :cascade
  add_foreign_key "order_items", "orders", name: "fk_order_items_orders", on_delete: :cascade
end
