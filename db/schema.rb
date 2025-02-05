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

ActiveRecord::Schema[8.0].define(version: 2025_02_05_052813) do
  create_table "crusts", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "inventories", force: :cascade do |t|
    t.integer "item_type", null: false
    t.integer "item_id", null: false
    t.integer "quantity", default: 0, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "user_id", null: false
    t.index ["user_id"], name: "index_inventories_on_user_id"
  end

  create_table "order_pizzas", force: :cascade do |t|
    t.integer "order_id", null: false
    t.integer "pizza_id", null: false
    t.integer "crust_id", null: false
    t.integer "size", null: false
    t.decimal "price", precision: 10, scale: 2, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["crust_id"], name: "index_order_pizzas_on_crust_id"
    t.index ["order_id"], name: "index_order_pizzas_on_order_id"
    t.index ["pizza_id"], name: "index_order_pizzas_on_pizza_id"
  end

  create_table "order_sides", force: :cascade do |t|
    t.integer "order_id", null: false
    t.integer "side_id", null: false
    t.decimal "price", precision: 10, scale: 2, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["order_id"], name: "index_order_sides_on_order_id"
    t.index ["side_id"], name: "index_order_sides_on_side_id"
  end

  create_table "order_toppings", force: :cascade do |t|
    t.integer "order_pizza_id", null: false
    t.integer "topping_id", null: false
    t.decimal "price", precision: 10, scale: 2, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["order_pizza_id"], name: "index_order_toppings_on_order_pizza_id"
    t.index ["topping_id"], name: "index_order_toppings_on_topping_id"
  end

  create_table "orders", force: :cascade do |t|
    t.integer "status", default: 0, null: false
    t.decimal "total_price", precision: 10, scale: 2, default: "0.0", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "user_id", null: false
    t.index ["user_id"], name: "index_orders_on_user_id"
  end

  create_table "pizzas", force: :cascade do |t|
    t.string "name"
    t.integer "category", null: false
    t.decimal "regular_price", precision: 10, scale: 2, null: false
    t.decimal "medium_price", precision: 10, scale: 2, null: false
    t.decimal "large_price", precision: 10, scale: 2, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_pizzas_on_name", unique: true
  end

  create_table "sides", force: :cascade do |t|
    t.string "name"
    t.decimal "price", precision: 10, scale: 2, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "toppings", force: :cascade do |t|
    t.string "name"
    t.integer "category", null: false
    t.decimal "price", precision: 10, scale: 2, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "email"
    t.string "password_digest", null: false
    t.boolean "admin", default: false
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
  end

  add_foreign_key "inventories", "users"
  add_foreign_key "order_pizzas", "crusts"
  add_foreign_key "order_pizzas", "orders"
  add_foreign_key "order_pizzas", "pizzas"
  add_foreign_key "order_sides", "orders"
  add_foreign_key "order_sides", "sides"
  add_foreign_key "order_toppings", "order_pizzas"
  add_foreign_key "order_toppings", "toppings"
  add_foreign_key "orders", "users"
end
