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

ActiveRecord::Schema.define(version: 20130706134534) do

  create_table "accounts", force: true do |t|
    t.string   "owner_first_name"
    t.string   "owner_last_name"
    t.string   "company_name"
    t.string   "email"
    t.hstore   "configuration"
    t.boolean  "active"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "accounts", ["company_name"], name: "index_accounts_on_company_name", using: :btree

  create_table "appointments", force: true do |t|
    t.integer  "account_id",  null: false
    t.integer  "user_id",     null: false
    t.integer  "employee_id", null: false
    t.integer  "client_id",   null: false
    t.datetime "time"
    t.integer  "duration"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "appointments", ["account_id", "employee_id", "time"], name: "index_appointments_on_account_id_and_employee_id_and_time", using: :btree
  add_index "appointments", ["account_id", "time"], name: "index_appointments_on_account_id_and_time", using: :btree
  add_index "appointments", ["account_id"], name: "index_appointments_on_account_id", using: :btree
  add_index "appointments", ["client_id"], name: "index_appointments_on_client_id", using: :btree
  add_index "appointments", ["employee_id"], name: "index_appointments_on_employee_id", using: :btree
  add_index "appointments", ["user_id"], name: "index_appointments_on_user_id", using: :btree

  create_table "clients", force: true do |t|
    t.integer  "account_id"
    t.string   "first_name"
    t.string   "last_name"
    t.date     "birthday"
    t.string   "email"
    t.string   "telefone_celular"
    t.string   "telefone_home"
    t.string   "telefone_office"
    t.hstore   "custom_fields"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "clients", ["first_name", "last_name"], name: "index_clients_on_first_name_and_last_name", using: :btree
  add_index "clients", ["first_name"], name: "index_clients_on_first_name", using: :btree
  add_index "clients", ["last_name"], name: "index_clients_on_last_name", using: :btree

  create_table "employees", force: true do |t|
    t.integer  "account_id"
    t.string   "first_name"
    t.string   "last_name"
    t.boolean  "active"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
    t.integer  "account_id"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "email"
    t.string   "password"
    t.string   "password_digest"
    t.boolean  "account_administrator"
    t.boolean  "active"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["email"], name: "index_users_on_email", using: :btree

  add_foreign_key "appointments", "accounts", :name => "appointments_account_id_fk"
  add_foreign_key "appointments", "clients", :name => "appointments_client_id_fk"
  add_foreign_key "appointments", "employees", :name => "appointments_employee_id_fk"
  add_foreign_key "appointments", "users", :name => "appointments_user_id_fk"

  add_foreign_key "clients", "accounts", :name => "clients_account_id_fk"

  add_foreign_key "employees", "accounts", :name => "employees_account_id_fk"

  add_foreign_key "users", "accounts", :name => "users_account_id_fk"

end
