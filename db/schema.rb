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

ActiveRecord::Schema.define(version: 20131028115931) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "likes", force: true do |t|
    t.integer  "user_id"
    t.integer  "likeable_id"
    t.string   "likeable_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "likes", ["likeable_id", "likeable_type"], name: "index_likes_on_likeable_id_and_likeable_type", using: :btree
  add_index "likes", ["user_id", "likeable_id", "likeable_type"], name: "index_likes_on_user_id_and_likeable_id_and_likeable_type", unique: true, using: :btree
  add_index "likes", ["user_id"], name: "index_likes_on_user_id", using: :btree

  create_table "nodes", force: true do |t|
    t.string   "name"
    t.string   "key"
    t.string   "description"
    t.integer  "topics_count", default: 0
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "nodes", ["key"], name: "index_nodes_on_key", unique: true, using: :btree

  create_table "notifications", force: true do |t|
    t.integer  "user_id"
    t.integer  "reply_id"
    t.boolean  "is_read",          default: false
    t.integer  "mentionable_id"
    t.string   "mentionable_type"
    t.string   "type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "notifications", ["is_read"], name: "index_notifications_on_is_read", using: :btree
  add_index "notifications", ["mentionable_id", "mentionable_type"], name: "index_notifications_on_mentionable_id_and_mentionable_type", using: :btree
  add_index "notifications", ["reply_id"], name: "index_notifications_on_reply_id", using: :btree
  add_index "notifications", ["user_id"], name: "index_notifications_on_user_id", using: :btree

  create_table "replies", force: true do |t|
    t.text     "body"
    t.text     "body_html"
    t.integer  "user_id"
    t.integer  "topic_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "replies", ["topic_id"], name: "index_replies_on_topic_id", using: :btree
  add_index "replies", ["user_id"], name: "index_replies_on_user_id", using: :btree

  create_table "topics", force: true do |t|
    t.string   "title"
    t.text     "body"
    t.text     "body_html"
    t.integer  "hits",               default: 0
    t.integer  "likes_count",        default: 0
    t.integer  "replies_count",      default: 0
    t.integer  "last_replier_id"
    t.integer  "user_id"
    t.integer  "node_id"
    t.integer  "active_replier_ids", default: [], array: true
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "topics", ["node_id"], name: "index_topics_on_node_id", using: :btree
  add_index "topics", ["user_id"], name: "index_topics_on_user_id", using: :btree

  create_table "users", force: true do |t|
    t.integer  "replies_count",          default: 0
    t.integer  "topics_count",           default: 0
    t.boolean  "admin",                  default: false, null: false
    t.string   "username",               default: "",    null: false
    t.string   "email",                  default: "",    null: false
    t.string   "encrypted_password",     default: "",    null: false
    t.string   "provider"
    t.string   "uid"
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "avatar_file_name"
    t.string   "avatar_content_type"
    t.integer  "avatar_file_size"
    t.datetime "avatar_updated_at"
  end

  add_index "users", ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true, using: :btree
  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  add_index "users", ["username"], name: "index_users_on_username", unique: true, using: :btree

end
