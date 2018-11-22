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

ActiveRecord::Schema.define(version: 20181122210927) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "active_services", force: :cascade do |t|
    t.integer "service_id"
    t.integer "server_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "status", default: 0
    t.index ["server_id"], name: "index_active_services_on_server_id"
    t.index ["service_id"], name: "index_active_services_on_service_id"
  end

  create_table "apps", force: :cascade do |t|
    t.integer "server_id"
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "busy", default: false
    t.boolean "backups_enabled", default: false
    t.text "ssl_key"
    t.text "ssl_cert"
    t.boolean "ssl_enabled", default: false
    t.string "letsencrypt_email"
    t.index ["server_id"], name: "index_apps_on_server_id"
  end

  create_table "backups", force: :cascade do |t|
    t.string "filename"
    t.integer "service_id"
    t.integer "app_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "running", default: false
    t.integer "backup_type", default: 0
    t.boolean "rotated", default: false
    t.index ["app_id"], name: "index_backups_on_app_id"
    t.index ["service_id"], name: "index_backups_on_service_id"
  end

  create_table "deploy_keys", force: :cascade do |t|
    t.string "name"
    t.text "key"
    t.integer "server_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["server_id"], name: "index_deploy_keys_on_server_id"
  end

  create_table "domains", force: :cascade do |t|
    t.integer "app_id"
    t.string "name"
    t.index ["app_id"], name: "index_domains_on_app_id"
  end

  create_table "env_vars", force: :cascade do |t|
    t.string "key"
    t.string "value"
    t.integer "app_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["app_id"], name: "index_env_vars_on_app_id"
  end

  create_table "integrations", force: :cascade do |t|
    t.string "name"
    t.string "access_token"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "linked_services", force: :cascade do |t|
    t.integer "app_id"
    t.integer "service_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "status", default: 0
    t.index ["app_id"], name: "index_linked_services_on_app_id"
    t.index ["service_id"], name: "index_linked_services_on_service_id"
  end

  create_table "servers", force: :cascade do |t|
    t.string "name"
    t.string "ip"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text "rsa_key_public"
    t.text "rsa_key_private"
    t.boolean "connected", default: false
    t.integer "status", default: 0
    t.string "dokku_version"
    t.boolean "updating", default: false
    t.integer "install_step", default: 1
    t.boolean "swap_enabled", default: false
    t.integer "total_ram"
    t.integer "total_disk"
    t.integer "total_cpu"
    t.string "username", default: "root"
  end

  create_table "services", force: :cascade do |t|
    t.string "name"
    t.boolean "active", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.json "commands"
  end

  create_table "settings", force: :cascade do |t|
    t.string "from_email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "enable_smtp", default: false
    t.string "smtp_address"
    t.integer "smtp_port"
    t.string "smtp_username"
    t.string "smtp_password"
    t.string "smtp_domain"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", null: false
    t.string "crypted_password"
    t.string "salt"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string "activation_token"
    t.string "totp_secret"
    t.boolean "two_factor_auth_enabled", default: false
    t.string "remember_me_token"
    t.datetime "remember_me_token_expires_at"
    t.string "reset_password_token"
    t.datetime "reset_password_token_expires_at"
    t.index ["activation_token"], name: "index_users_on_activation_token"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["remember_me_token"], name: "index_users_on_remember_me_token"
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token"
  end

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
