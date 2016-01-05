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

ActiveRecord::Schema.define(version: 20160105055607) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "alumni_memberships", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "stripe_subscription_id"
    t.string   "stripe_token"
    t.integer  "amount"
    t.string   "interval",               default: "month"
    t.date     "deactivated_on"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "status",                 default: "pending"
  end

  add_index "alumni_memberships", ["user_id"], name: "index_alumni_memberships_on_user_id", using: :btree

  create_table "donations", force: :cascade do |t|
    t.string   "name"
    t.string   "email"
    t.text     "comment"
    t.integer  "amount_cents"
    t.string   "stripe_token"
    t.string   "stripe_charge_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "card_type"
    t.string   "card_last4"
    t.date     "card_expiration"
  end

  create_table "intro_meeting_registrations", force: :cascade do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "email"
    t.integer  "intro_meeting_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "intro_meeting_registrations", ["intro_meeting_id"], name: "index_intro_meeting_registrations_on_intro_meeting_id", using: :btree

  create_table "intro_meetings", force: :cascade do |t|
    t.date     "date"
    t.time     "starts_at"
    t.time     "ends_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "meetings", force: :cascade do |t|
    t.datetime "starts_at"
    t.datetime "ends_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "title"
    t.integer  "position"
    t.integer  "workshop_id"
  end

  add_index "meetings", ["workshop_id"], name: "index_meetings_on_workshop_id", using: :btree

  create_table "payments", force: :cascade do |t|
    t.integer  "user_id"
    t.date     "date"
    t.string   "stripe_invoice_id"
    t.string   "card_last4"
    t.boolean  "email_sent"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "amount_cents"
    t.string   "stripe_customer_id"
    t.string   "stripe_charge_id"
    t.string   "guid"
    t.string   "description"
    t.boolean  "paid"
  end

  add_index "payments", ["guid"], name: "index_payments_on_guid", unique: true, using: :btree
  add_index "payments", ["user_id"], name: "index_payments_on_user_id", using: :btree

  create_table "stripe_webhooks", force: :cascade do |t|
    t.string   "stripe_id"
    t.string   "stripe_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: :cascade do |t|
    t.string   "email"
    t.string   "name"
    t.string   "phone_number"
    t.string   "address1"
    t.string   "address2"
    t.string   "city"
    t.string   "state"
    t.string   "zip_code"
    t.date     "birthday"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "encrypted_password",     limit: 128
    t.string   "confirmation_token",     limit: 128
    t.string   "remember_token",         limit: 128
    t.boolean  "admin",                              default: false
    t.string   "stripe_customer_id"
    t.string   "stripe_token"
    t.string   "card_type"
    t.string   "card_last4"
    t.date     "card_expiration"
    t.string   "username"
    t.integer  "sign_in_count",                      default: 0,     null: false
    t.datetime "last_sign_in_at"
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "current_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
  end

  add_index "users", ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true, using: :btree
  add_index "users", ["email"], name: "index_users_on_email", using: :btree
  add_index "users", ["remember_token"], name: "index_users_on_remember_token", using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  add_index "users", ["username"], name: "index_users_on_username", unique: true, using: :btree

  create_table "versions", force: :cascade do |t|
    t.string   "item_type",      null: false
    t.integer  "item_id",        null: false
    t.string   "event",          null: false
    t.string   "whodunnit"
    t.text     "object"
    t.datetime "created_at"
    t.text     "object_changes"
  end

  add_index "versions", ["item_type", "item_id"], name: "index_versions_on_item_type_and_item_id", using: :btree

  create_table "workshop_enrollments", force: :cascade do |t|
    t.integer  "user_id",                 null: false
    t.integer  "workshop_id",             null: false
    t.integer  "role",        default: 0
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "workshop_enrollments", ["workshop_id", "user_id"], name: "index_workshop_enrollments_on_workshop_id_and_user_id", unique: true, using: :btree

  create_table "workshops", force: :cascade do |t|
    t.string   "title"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name"
    t.boolean  "active",      default: false
  end

end
