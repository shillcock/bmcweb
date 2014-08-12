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

ActiveRecord::Schema.define(version: 20140801060105) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "alumni_memberships", force: true do |t|
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

  create_table "donations", force: true do |t|
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

  create_table "intro_meeting_registrations", force: true do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "email"
    t.integer  "intro_meeting_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "intro_meeting_registrations", ["intro_meeting_id"], name: "index_intro_meeting_registrations_on_intro_meeting_id", using: :btree

  create_table "intro_meetings", force: true do |t|
    t.date     "date"
    t.time     "starts_at"
    t.time     "ends_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "meetings", force: true do |t|
    t.datetime "starts_at"
    t.datetime "ends_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "title"
    t.integer  "position"
    t.integer  "workshop_id"
  end

  add_index "meetings", ["workshop_id"], name: "index_meetings_on_workshop_id", using: :btree

  create_table "roles", force: true do |t|
    t.string   "name"
    t.integer  "resource_id"
    t.string   "resource_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "roles", ["name", "resource_type", "resource_id"], name: "index_roles_on_name_and_resource_type_and_resource_id", using: :btree
  add_index "roles", ["name"], name: "index_roles_on_name", using: :btree

  create_table "section_enrollments_roles", id: false, force: true do |t|
    t.integer "section_enrollment_id"
    t.integer "role_id"
  end

  add_index "section_enrollments_roles", ["section_enrollment_id", "role_id"], name: "index_section_enrollments_roles_se_id_and_role_id", using: :btree

  create_table "users", force: true do |t|
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
    t.string   "encrypted_password", limit: 128
    t.string   "confirmation_token", limit: 128
    t.string   "remember_token",     limit: 128
    t.boolean  "admin",                          default: false
    t.string   "stripe_customer_id"
    t.string   "stripe_token"
    t.string   "card_type"
    t.string   "card_last4"
    t.date     "card_expiration"
  end

  add_index "users", ["email"], name: "index_users_on_email", using: :btree
  add_index "users", ["remember_token"], name: "index_users_on_remember_token", using: :btree

  create_table "versions", force: true do |t|
    t.string   "item_type",      null: false
    t.integer  "item_id",        null: false
    t.string   "event",          null: false
    t.string   "whodunnit"
    t.text     "object"
    t.datetime "created_at"
    t.text     "object_changes"
  end

  add_index "versions", ["item_type", "item_id"], name: "index_versions_on_item_type_and_item_id", using: :btree

  create_table "workshop_enrollments", force: true do |t|
    t.integer  "user_id",      null: false
    t.integer  "workhshop_id", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "workshop_enrollments", ["workhshop_id", "user_id"], name: "index_workshop_enrollments_on_workhshop_id_and_user_id", unique: true, using: :btree

  create_table "workshops", force: true do |t|
    t.string   "title"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name"
    t.boolean  "active",      default: false
  end

  add_index "workshops", ["name"], name: "index_workshops_on_name", unique: true, using: :btree

end
