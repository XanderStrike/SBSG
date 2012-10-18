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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20121018050232) do

  create_table "employees", :force => true do |t|
    t.string   "name"
    t.integer  "mon_start"
    t.integer  "mon_end"
    t.integer  "tue_start"
    t.integer  "tue_end"
    t.integer  "wed_start"
    t.integer  "wed_end"
    t.integer  "thu_start"
    t.integer  "thu_end"
    t.integer  "fri_start"
    t.integer  "fri_end"
    t.integer  "sat_start"
    t.integer  "sat_end"
    t.integer  "sun_start"
    t.integer  "sun_end"
    t.string   "days_off"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

end
