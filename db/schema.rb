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

ActiveRecord::Schema.define(:version => 20111118215247) do

  create_table "categories", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "comments", :force => true do |t|
    t.string   "commenter"
    t.text     "body"
    t.integer  "quest_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
  end

  add_index "comments", ["quest_id"], :name => "index_comments_on_quest_id"

  create_table "experiences", :force => true do |t|
    t.integer  "joiner_id"
    t.integer  "joined_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "experiences", ["joined_id"], :name => "index_experiences_on_joined_id"
  add_index "experiences", ["joiner_id", "joined_id"], :name => "index_experiences_on_joiner_id_and_joined_id", :unique => true
  add_index "experiences", ["joiner_id"], :name => "index_experiences_on_joiner_id"

  create_table "quests", :force => true do |t|
    t.string   "title"
    t.date     "start"
    t.date     "enddate"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "photo_file_name"
    t.string   "photo_content_type"
    t.integer  "photo_file_size"
    t.datetime "photo_updated_at"
    t.integer  "user_id"
    t.integer  "category_id"
  end

  create_table "users", :force => true do |t|
    t.string   "email"
    t.string   "name"
    t.string   "password_digest"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "admin",           :default => false
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true

end
