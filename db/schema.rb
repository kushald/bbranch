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

ActiveRecord::Schema.define(version: 20140419182349) do

  create_table "banks", force: true do |t|
    t.string   "serial_no"
    t.string   "region"
    t.string   "state"
    t.string   "district"
    t.string   "center"
    t.string   "bank_group"
    t.string   "bank"
    t.string   "branch"
    t.string   "part1_code"
    t.string   "part2_code"
    t.string   "population_group"
    t.string   "date_of_open"
    t.string   "ad_category"
    t.string   "licence_no"
    t.string   "licence_date"
    t.text     "address"
    t.string   "branch_office"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "ifscs", force: true do |t|
    t.string   "name"
    t.string   "ifsc"
    t.string   "micr"
    t.string   "branch"
    t.text     "address"
    t.string   "contact"
    t.string   "city"
    t.string   "district"
    t.string   "string"
    t.string   "state"
    t.integer  "neft_bank_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "ifscs", ["ifsc"], name: "index_ifscs_on_ifsc", unique: true, using: :btree

  create_table "neft_banks", force: true do |t|
    t.string   "name"
    t.string   "display_name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
