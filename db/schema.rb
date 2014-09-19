# encoding: UTF-8
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

ActiveRecord::Schema.define(version: 20140916072027) do

  create_table "delayed_jobs", force: true do |t|
    t.integer  "priority",   default: 0, null: false
    t.integer  "attempts",   default: 0, null: false
    t.text     "handler",                null: false
    t.text     "last_error"
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string   "locked_by"
    t.string   "queue"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "delayed_jobs", ["priority", "run_at"], name: "delayed_jobs_priority"

  create_table "departments", force: true do |t|
    t.string   "dep_id",       null: false
    t.string   "name",         null: false
    t.string   "alias"
    t.string   "docket_head"
    t.integer  "account_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "fixedasset_categories", force: true do |t|
    t.string   "cat_id",     null: false
    t.string   "cat_name",   null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

# Could not dump table "fixedasset_changeds" because of following NoMethodError
#   undefined method `[]' for nil:NilClass

  create_table "fixedasset_parts", force: true do |t|
    t.integer  "part_no"
    t.integer  "department_id"
    t.float    "weight",              default: 0.0
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "refed_department_id"
  end

  create_table "fixedasset_redepreciations", force: true do |t|
    t.string   "fixedasset_id",                   null: false
    t.integer  "re_original_value"
    t.integer  "re_final_scrap_value"
    t.integer  "re_depreciated_value_per_month"
    t.integer  "re_depreciated_value_last_month"
    t.date     "re_start_use_date"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.date     "re_end_use_date"
  end

  create_table "fixedassets", force: true do |t|
    t.string   "fixed_asset_id",                           null: false
    t.string   "ab_type",                                  null: false
    t.integer  "year",                                     null: false
    t.integer  "category_id",                              null: false
    t.string   "category_lv2",                             null: false
    t.integer  "serial_no",                                null: false
    t.integer  "sequence_no",                              null: false
    t.integer  "voucher_no"
    t.string   "name",                                     null: false
    t.text     "spec"
    t.integer  "quantity",                     default: 0, null: false
    t.string   "unit"
    t.integer  "original_cost"
    t.date     "get_date"
    t.integer  "service_life_year"
    t.integer  "service_life_month"
    t.integer  "depreciated_value_per_month"
    t.integer  "depreciated_value_last_month"
    t.integer  "department_id"
    t.integer  "vendor_id"
    t.integer  "status"
    t.text     "note"
    t.date     "start_use_date"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "username"
    t.integer  "depreciation84"
    t.integer  "final_scrap_value"
    t.boolean  "is_mortgaged"
    t.date     "end_use_date"
    t.date     "out_date"
  end

  add_index "fixedassets", ["is_mortgaged"], name: "index_fixedassets_on_is_mortgaged"

  create_table "users", force: true do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "username"
    t.boolean  "approved"
  end

  add_index "users", ["approved"], name: "index_users_on_approved"
  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  add_index "users", ["username"], name: "index_users_on_username", unique: true

  create_table "vendor_addresses", force: true do |t|
    t.integer  "vendor_id"
    t.integer  "address_type"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "building_and_street"
    t.string   "zipcode"
    t.string   "country"
  end

  create_table "vendor_contacts", force: true do |t|
    t.integer  "vendor_id",  null: false
    t.string   "name",       null: false
    t.string   "phone"
    t.string   "phone2"
    t.string   "phone3"
    t.string   "email"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "vendors", force: true do |t|
    t.string   "name",                null: false
    t.string   "alias"
    t.string   "fax"
    t.string   "vat_id"
    t.string   "product_type"
    t.string   "main_business"
    t.integer  "payment_location"
    t.integer  "payment_type"
    t.integer  "check_usance"
    t.string   "bank_id"
    t.string   "bank_account_id"
    t.string   "bank_account_name"
    t.string   "receipter_vat_id"
    t.integer  "notification_method"
    t.boolean  "is_pay_for_wire_fee"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "payment_time"
    t.string   "pic_name"
  end

  create_table "versions", force: true do |t|
    t.string   "item_type",  null: false
    t.integer  "item_id",    null: false
    t.string   "event",      null: false
    t.string   "whodunnit"
    t.text     "object"
    t.datetime "created_at"
  end

  add_index "versions", ["item_type", "item_id"], name: "index_versions_on_item_type_and_item_id"

end
