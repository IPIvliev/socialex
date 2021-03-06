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

ActiveRecord::Schema.define(:version => 20140423143522) do

  create_table "deals", :force => true do |t|
    t.integer  "user_id"
    t.integer  "host_id"
    t.integer  "seconduser_id"
    t.decimal  "price",         :precision => 9, :scale => 2
    t.integer  "status"
    t.integer  "amount"
    t.datetime "created_at",                                  :null => false
    t.datetime "updated_at",                                  :null => false
  end

  create_table "mystocks", :force => true do |t|
    t.integer  "user_id"
    t.integer  "host_id"
    t.decimal  "price",      :precision => 9, :scale => 2
    t.integer  "amount"
    t.datetime "created_at",                               :null => false
    t.datetime "updated_at",                               :null => false
  end

  create_table "orders", :force => true do |t|
    t.integer  "user_id",                                  :null => false
    t.integer  "host_id",                                  :null => false
    t.integer  "amount",                                   :null => false
    t.decimal  "price",      :precision => 9, :scale => 2
    t.integer  "status",                                   :null => false
    t.datetime "created_at",                               :null => false
    t.datetime "updated_at",                               :null => false
  end

  create_table "post_translations", :force => true do |t|
    t.integer  "post_id"
    t.string   "locale",     :null => false
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.string   "name"
    t.text     "text"
  end

  add_index "post_translations", ["locale"], :name => "index_post_translations_on_locale"
  add_index "post_translations", ["post_id"], :name => "index_post_translations_on_post_id"

  create_table "posts", :force => true do |t|
    t.string   "user_id"
    t.string   "picture"
    t.string   "text"
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "users", :force => true do |t|
    t.string   "provider"
    t.string   "uid"
    t.string   "name"
    t.string   "username"
    t.string   "oauth_token"
    t.datetime "oauth_expires_at"
    t.decimal  "pocket",           :precision => 9, :scale => 2, :default => 0.0
    t.decimal  "price",            :precision => 9, :scale => 2, :default => 100.0
    t.integer  "role",                                           :default => 0
    t.datetime "created_at",                                                        :null => false
    t.datetime "updated_at",                                                        :null => false
  end

end
