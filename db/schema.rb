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

ActiveRecord::Schema.define(version: 20160105114048) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "active_services", force: :cascade do |t|
    t.integer  "service_id"
    t.integer  "server_id"
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
    t.integer  "status",     default: 0
  end

  add_index "active_services", ["server_id"], name: "index_active_services_on_server_id", using: :btree
  add_index "active_services", ["service_id"], name: "index_active_services_on_service_id", using: :btree

  create_table "apps", force: :cascade do |t|
    t.integer  "server_id"
    t.string   "name"
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
    t.boolean  "busy",            default: false
    t.boolean  "backups_enabled", default: false
  end

  add_index "apps", ["server_id"], name: "index_apps_on_server_id", using: :btree

  create_table "backups", force: :cascade do |t|
    t.string   "filename"
    t.integer  "service_id"
    t.integer  "app_id"
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
    t.boolean  "running",    default: false
  end

  add_index "backups", ["app_id"], name: "index_backups_on_app_id", using: :btree
  add_index "backups", ["service_id"], name: "index_backups_on_service_id", using: :btree

  create_table "deploy_keys", force: :cascade do |t|
    t.string   "name"
    t.text     "key"
    t.integer  "server_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "deploy_keys", ["server_id"], name: "index_deploy_keys_on_server_id", using: :btree

  create_table "domains", force: :cascade do |t|
    t.integer "app_id"
    t.string  "name"
  end

  add_index "domains", ["app_id"], name: "index_domains_on_app_id", using: :btree

  create_table "env_vars", force: :cascade do |t|
    t.string   "key"
    t.string   "value"
    t.integer  "app_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "env_vars", ["app_id"], name: "index_env_vars_on_app_id", using: :btree

  create_table "linked_services", force: :cascade do |t|
    t.integer  "app_id"
    t.integer  "service_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "linked_services", ["app_id"], name: "index_linked_services_on_app_id", using: :btree
  add_index "linked_services", ["service_id"], name: "index_linked_services_on_service_id", using: :btree

  create_table "servers", force: :cascade do |t|
    t.string   "name"
    t.string   "ip"
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
    t.text     "rsa_key_public"
    t.text     "rsa_key_private"
    t.boolean  "connected",       default: false
    t.integer  "status",          default: 0
    t.string   "dokku_version"
  end

  create_table "services", force: :cascade do |t|
    t.string   "name"
    t.boolean  "active",     default: false
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
    t.json     "commands"
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",            null: false
    t.string   "crypted_password"
    t.string   "salt"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree

  add_foreign_key "active_services", "servers"
  add_foreign_key "active_services", "services"
  add_foreign_key "apps", "servers"
  add_foreign_key "backups", "apps"
  add_foreign_key "backups", "services"
  add_foreign_key "deploy_keys", "servers"
  add_foreign_key "domains", "apps"
  add_foreign_key "env_vars", "apps"
  add_foreign_key "linked_services", "apps"
  add_foreign_key "linked_services", "services"
end
