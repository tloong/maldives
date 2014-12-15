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

ActiveRecord::Schema.define(version: 20141204055248) do

  create_table "acceptance_certifications", force: true do |t|
    t.string   "accept_cert_no"
    t.date     "accept_cert_date"
    t.integer  "currency"
    t.float    "exchange_rate"
    t.float    "amount"
    t.float    "tax"
    t.float    "discount_amount"
    t.float    "discount_tax"
    t.string   "invoice_no"
    t.date     "invoice_date"
    t.text     "note_for_payment"
    t.string   "voucher_no"
    t.date     "voucher_date"
    t.integer  "acc_type"
    t.integer  "vendor_id"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "department_id"
  end

  create_table "acceptance_lineitems", force: true do |t|
    t.integer  "acceptance_certification_id"
    t.integer  "purchasing_order_lineitem_id"
    t.float    "received_quantity"
    t.float    "accepted_quantity"
    t.float    "ng_quantity"
    t.float    "unit_price"
    t.float    "total_amount"
    t.float    "tax"
    t.float    "discount_amount"
    t.float    "discount_tax"
    t.integer  "received_department_id"
    t.integer  "acc_type"
    t.integer  "cost_department_id"
    t.integer  "special_flag"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "material_id"
  end

  create_table "addresses", force: true do |t|
    t.text     "line1_address_building"
    t.string   "line2_address_street"
    t.string   "city"
    t.integer  "zipcode"
    t.string   "state_province_county"
    t.string   "country"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

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

  create_table "fixedasset_changeds", force: true do |t|
    t.integer  "fixedasset_id",         null: false
    t.integer  "voucher_no"
    t.integer  "department_id"
    t.integer  "price"
    t.date     "changed_date"
    t.string   "username"
    t.text     "reason"
    t.text     "note"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "old_department_id"
    t.integer  "change_type"
    t.integer  "evaluated_value"
    t.integer  "evaluated_scrap_value"
  end

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

  create_table "material_cat_lv1s", force: true do |t|
    t.string   "cat_id"
    t.string   "cat_name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "material_cat_lv2s", force: true do |t|
    t.string   "cat_id"
    t.string   "cat_name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "material_cats", force: true do |t|
    t.string   "lv2"
    t.string   "cat_id"
    t.string   "cat_name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "material_vendors", force: true do |t|
    t.string   "sno"
    t.string   "name"
    t.string   "sid"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "materials", force: true do |t|
    t.string   "mat_id"
    t.string   "vendor_lot_no"
    t.integer  "material_cat_lv1_id"
    t.integer  "material_cat_lv2_id"
    t.string   "name"
    t.string   "condition_id"
    t.text     "description"
    t.text     "note"
    t.integer  "accounting_type"
    t.integer  "debit_code"
    t.integer  "credit_code"
    t.boolean  "is_shared_id"
    t.boolean  "is_quantity_control"
    t.boolean  "is_sample"
    t.string   "measure_unit"
    t.string   "vendor_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "safe_quantity"
    t.integer  "stocktake_quantity"
    t.integer  "last_quantity"
    t.integer  "total_quantity"
    t.string   "sno"
  end

  create_table "meetings", force: true do |t|
    t.string   "meetingname"
    t.date     "date"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "purchasing_order_lineitems", force: true do |t|
    t.integer  "purchasing_order_id"
    t.integer  "sequence_no"
    t.integer  "material_id"
    t.integer  "quantity"
    t.float    "purchased_unit_price"
    t.float    "amount"
    t.float    "tax"
    t.string   "purchasing_requisition_no"
    t.integer  "purchasing_requsition_seq_no"
    t.string   "purchasing_purpose"
    t.date     "purchasing_requisition_date"
    t.date     "goods_need_date"
    t.integer  "shipping_location"
    t.integer  "acceptance_certification_no"
    t.boolean  "close_case"
    t.integer  "acc_type"
    t.integer  "cost_department"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "purchasing_orders", force: true do |t|
    t.string   "purchasing_order_on"
    t.date     "purchase_date"
    t.integer  "vendor_id"
    t.integer  "department_id"
    t.integer  "currency"
    t.float    "exchange_rate"
    t.float    "amount"
    t.integer  "payment_location"
    t.integer  "payment_type"
    t.integer  "check_usance"
    t.integer  "purchase_method"
    t.integer  "purchase_category"
    t.integer  "purchase_employee"
    t.boolean  "is_prepaid"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "quality_testings", force: true do |t|
    t.integer  "vendor_id",                      null: false
    t.date     "test_date",                      null: false
    t.string   "spec",                           null: false
    t.string   "lot_no"
    t.float    "denier",           default: 0.0
    t.float    "strength",         default: 0.0
    t.float    "elongation",       default: 0.0
    t.float    "oil_content",      default: 0.0
    t.float    "shrinkage",        default: 0.0
    t.integer  "entangling_value", default: 0
    t.float    "cr_value",         default: 0.0
    t.text     "note"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "repair_acceptance_certificate_lines", force: true do |t|
    t.integer  "repair_acceptance_certificate_id"
    t.integer  "sequence_no"
    t.integer  "material_id"
    t.float    "received_quantity"
    t.float    "unit_price"
    t.float    "total_amount"
    t.float    "tax"
    t.float    "discount_amount"
    t.float    "discount_tax"
    t.text     "repair_reason"
    t.integer  "machine_category"
    t.integer  "machine_id"
    t.integer  "repair_requisition_department"
    t.integer  "cost_department"
    t.date     "repair_accept_cert_date"
    t.integer  "acc_type"
    t.integer  "speical_code"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "repair_acceptance_certificates", force: true do |t|
    t.string   "repair_accept_cert_no"
    t.date     "request_date"
    t.string   "repair_requisition_no"
    t.integer  "repair_requisition_department"
    t.date     "accept_cert_date"
    t.integer  "accept_cert_department"
    t.integer  "vendor_id"
    t.float    "amount"
    t.float    "tax"
    t.float    "discount_amount"
    t.float    "discount_tax"
    t.string   "invoice_no"
    t.date     "invoice_date"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "reports", force: true do |t|
    t.integer  "meeting_id"
    t.string   "name"
    t.text     "module"
    t.text     "this_week_work"
    t.text     "need_help"
    t.text     "next_week_work"
    t.text     "share_tech"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
    t.string   "email",                  default: "",    null: false
    t.string   "encrypted_password",     default: "",    null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "username"
    t.boolean  "approved"
    t.boolean  "is_admin",               default: false
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
