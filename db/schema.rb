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

ActiveRecord::Schema.define(:version => 20150625144857) do

  create_table "apps", :force => true do |t|
    t.string   "api_token"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.string   "name"
    t.string   "uid"
  end

  create_table "bills", :force => true do |t|
    t.string   "uid"
    t.string   "description"
    t.integer  "group_id"
    t.integer  "price_cents"
    t.string   "currency"
    t.decimal  "units",             :precision => 10, :scale => 2
    t.datetime "period_started_at"
    t.datetime "period_ended_at"
    t.datetime "created_at",                                                          :null => false
    t.datetime "updated_at",                                                          :null => false
    t.string   "status"
    t.integer  "recurring_bill_id"
    t.boolean  "third_party",                                      :default => false
  end

  create_table "connec_entities", :force => true do |t|
    t.string   "uid"
    t.text     "document"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
    t.string   "group_id"
    t.string   "entity_name"
  end

  create_table "group_user_rels", :force => true do |t|
    t.integer  "group_id"
    t.integer  "user_id"
    t.string   "role"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "groups", :force => true do |t|
    t.string   "name"
    t.string   "uid"
    t.datetime "created_at",        :null => false
    t.datetime "updated_at",        :null => false
    t.integer  "app_id"
    t.datetime "free_trial_end_at"
  end

  create_table "open_id_associations", :force => true do |t|
    t.binary   "server_url", :null => false
    t.string   "handle",     :null => false
    t.binary   "secret",     :null => false
    t.integer  "issued",     :null => false
    t.integer  "lifetime",   :null => false
    t.string   "assoc_type", :null => false
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "open_id_nonces", :force => true do |t|
    t.string   "server_url", :null => false
    t.integer  "timestamp",  :null => false
    t.string   "salt",       :null => false
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "recurring_bills", :force => true do |t|
    t.string   "uid"
    t.string   "period"
    t.integer  "frequency"
    t.integer  "cycles"
    t.datetime "start_date"
    t.string   "description"
    t.string   "status"
    t.integer  "price_cents"
    t.string   "currency"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
    t.integer  "group_id"
    t.integer  "initial_cents"
    t.datetime "setup_at"
  end

  create_table "users", :force => true do |t|
    t.string   "email"
    t.string   "name"
    t.string   "surname"
    t.string   "geo_country_code"
    t.string   "uid"
    t.string   "sso_session"
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
    t.string   "company"
  end

end
