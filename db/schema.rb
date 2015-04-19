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

ActiveRecord::Schema.define(version: 20150419083537) do

  create_table "ratings", force: :cascade do |t|
    t.string "member"
    t.string "milestone"
    t.string "ko"
    t.string "comment"
  end

  add_index "ratings", ["member", "milestone"], name: "index_ratings_on_member_and_milestone", unique: true
  add_index "ratings", ["member"], name: "index_ratings_on_member"

end
