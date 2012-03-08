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

ActiveRecord::Schema.define(:version => 20120308130816) do

  create_table "administrations", :force => true do |t|
    t.integer  "user_id"
    t.integer  "domain_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", :force => true do |t|
    t.string   "username"
    t.string   "password_hash"
    t.string   "password_salt"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "last_login"
    t.boolean  "admin",         :default => false
  end

  create_table "virtual_aliases", :force => true do |t|
    t.integer  "domain_id"
    t.string   "source"
    t.string   "destination"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "virtual_domains", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "max_mailboxes"
    t.integer  "max_mailaliases"
  end

  create_table "virtual_users", :force => true do |t|
    t.integer  "domain_id"
    t.string   "email"
    t.string   "password"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "quota_kb"
    t.integer  "quota_messages"
    t.datetime "last_login"
  end

end
