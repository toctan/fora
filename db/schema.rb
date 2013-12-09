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
    t.string   "name",                               null: false
    t.string   "key",                                null: false
    t.string   "color"
    t.string   "description"
    t.integer  "topics_count",       default: 0
    t.boolean  "approved",           default: false, null: false
    t.integer  "user_id"
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "nodes", ["approved"], name: "index_nodes_on_approved", using: :btree
  add_index "nodes", ["key"], name: "index_nodes_on_key", unique: true, using: :btree
  add_index "nodes", ["user_id"], name: "index_nodes_on_user_id", using: :btree

  create_table "notifications", force: true do |t|
    t.integer  "target_id"
    t.integer  "source_id"
    t.integer  "topic_id"
    t.integer  "reply_id"
    t.integer  "like_id"
    t.boolean  "is_read",    default: false
    t.string   "kind",                       null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "notifications", ["is_read"], name: "index_notifications_on_is_read", using: :btree
  add_index "notifications", ["like_id"], name: "index_notifications_on_like_id", using: :btree
  add_index "notifications", ["reply_id"], name: "index_notifications_on_reply_id", using: :btree
  add_index "notifications", ["source_id"], name: "index_notifications_on_source_id", using: :btree
  add_index "notifications", ["target_id"], name: "index_notifications_on_target_id", using: :btree
  add_index "notifications", ["topic_id"], name: "index_notifications_on_topic_id", using: :btree

  create_table "replies", force: true do |t|
    t.text     "body",                    null: false
    t.integer  "user_id"
    t.integer  "topic_id"
    t.integer  "likes_count", default: 0
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "replies", ["topic_id"], name: "index_replies_on_topic_id", using: :btree
  add_index "replies", ["user_id"], name: "index_replies_on_user_id", using: :btree

  create_table "topics", force: true do |t|
    t.string   "title",                             null: false
    t.text     "body"
    t.integer  "likes_count",           default: 0
    t.integer  "replies_count",         default: 0
    t.string   "last_replier_username"
    t.integer  "user_id"
    t.integer  "node_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "topics", ["node_id"], name: "index_topics_on_node_id", using: :btree
  add_index "topics", ["user_id"], name: "index_topics_on_user_id", using: :btree

  create_table "users", force: true do |t|
    t.string   "uid"
    t.string   "username"
    t.string   "provider"
    t.boolean  "admin",               default: false, null: false
    t.string   "avatar_file_name"
    t.string   "avatar_content_type"
    t.integer  "avatar_file_size"
    t.datetime "avatar_updated_at"
    t.integer  "replies_count",       default: 0
    t.integer  "topics_count",        default: 0
    t.integer  "bookmarks",           default: [],                 array: true
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["provider", "uid"], name: "index_users_on_provider_and_uid", unique: true, using: :btree
  add_index "users", ["username"], name: "index_users_on_username", unique: true, using: :btree

end
