# frozen_string_literal: true

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

ActiveRecord::Schema[7.0].define(version: 20_220_506_145_015) do
  create_table 'addresses', force: :cascade do |t|
    t.string 'first_name'
    t.string 'last_name'
    t.string 'city'
    t.string 'zip_code'
    t.string 'street'
    t.string 'email'
    t.integer 'order_id', null: false
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index ['order_id'], name: 'index_addresses_on_order_id'
  end

  create_table 'categories', force: :cascade do |t|
    t.string 'name'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
  end

  create_table 'line_items', force: :cascade do |t|
    t.integer 'product_id', null: false
    t.decimal 'unit_price'
    t.integer 'quantity'
    t.integer 'order_id', null: false
    t.string 'item_name'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index ['order_id'], name: 'index_line_items_on_order_id'
    t.index ['product_id'], name: 'index_line_items_on_product_id'
  end

  create_table 'order_transitions', force: :cascade do |t|
    t.string 'to_state', null: false
    t.text 'metadata', default: '{}'
    t.integer 'sort_key', null: false
    t.integer 'order_id', null: false
    t.boolean 'most_recent', null: false
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index %w[order_id most_recent], name: 'index_order_transitions_parent_most_recent', unique: true,
                                      where: 'most_recent'
    t.index %w[order_id sort_key], name: 'index_order_transitions_parent_sort', unique: true
  end

  create_table 'orders', force: :cascade do |t|
    t.text 'comment'
    t.integer 'shipping_type_id'
    t.decimal 'shipping_cost'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index ['shipping_type_id'], name: 'index_orders_on_shipping_type_id'
  end

  create_table 'products', force: :cascade do |t|
    t.string 'name'
    t.text 'description'
    t.text 'long_description'
    t.string 'photo'
    t.decimal 'price'
    t.integer 'category_id', null: false
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index ['category_id'], name: 'index_products_on_category_id'
  end

  create_table 'shipping_types', force: :cascade do |t|
    t.string 'name'
    t.decimal 'cost'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
  end

  add_foreign_key 'addresses', 'orders'
  add_foreign_key 'line_items', 'orders'
  add_foreign_key 'line_items', 'products'
  add_foreign_key 'order_transitions', 'orders'
  add_foreign_key 'orders', 'shipping_types'
  add_foreign_key 'products', 'categories'
end
