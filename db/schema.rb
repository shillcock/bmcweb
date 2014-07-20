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

ActiveRecord::Schema.define(version: 20140712045018) do

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

  create_table "lessons", force: true do |t|
    t.string   "title"
    t.text     "summary"
    t.integer  "lesson_number"
    t.integer  "workshop_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "lessons", ["workshop_id"], name: "index_lessons_on_workshop_id", using: :btree

  create_table "meetings", force: true do |t|
    t.datetime "starts_at"
    t.datetime "ends_at"
    t.integer  "lesson_id"
    t.integer  "section_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "meetings", ["lesson_id"], name: "index_meetings_on_lesson_id", using: :btree
  add_index "meetings", ["section_id"], name: "index_meetings_on_section_id", using: :btree

  create_table "section_enrollments", force: true do |t|
    t.integer  "user_id",                null: false
    t.integer  "section_id",             null: false
    t.integer  "role",       default: 0
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "section_enrollments", ["section_id", "user_id"], name: "index_section_enrollments_on_section_id_and_user_id", unique: true, using: :btree

  create_table "sections", force: true do |t|
    t.integer  "workshop_id"
    t.string   "title"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "sections", ["workshop_id"], name: "index_sections_on_workshop_id", using: :btree

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

  create_table "workshops", force: true do |t|
    t.string   "title"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
